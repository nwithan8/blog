## Including non-code assets in your NuGet package

I've been working on a NuGet package recently, a small library that provides extensions and helper methods for
the [.NET EasyPost API client library](https://github.com/EasyPost/easypost-csharp).

One new feature I am looking to add is some helper functions that will generate random data for testing purposes. I
won't get into the weeds about how it works; the relevant part is that the library extracts dummy data from JSON files.

These JSON files obviously need to exist for them to be read and parsed during execution, which means three things:

- They need to be included in the compiled project during the build process (so that they are available when testing my
  library locally on my machine)
- They need to be included in the final NuGet package (so that they are distributed to anyone who installs my package)
- They need to be imported from the NuGet package into the end user's compiled project during their build process (so
  that they are available when the end user runs their application that uses my library)

The first two are easy enough to accomplish. The third is where things get a little more complicated. But for sanity's
sake (both yours and mine), I'm going to go over my finding of all three steps.

### Ground rules

Throughout this post, I will use the following terms:

- **Project A** is my project, the source code that I am writing that will become a NuGet package.
- **Project B** is the end user's project, the project that will consume my NuGet package. I do not have access to this
  project's source code, and I do not want to have to modify it in any way other than requiring the user to add my NuGet
  package as a dependency.
- **NuGet package** is the package that I will publish to NuGet.org. This is the package made of Project A's DLLs and
  asset files that will be consumed by Project B.
- **Asset files** are the non-code files that I want to include in my NuGet package alongside the DLLs. In this case,
  they are JSON files, but these could realistically be any type of files, such as images, text files, binaries, etc.
- **Compiled project** is the output of the build process for Project A. The compiled project is often stored in a
  `bin/` directory, and it contains the compiled DLLs and asset files. These files are used locally to run the project (
  i.e. during unit tests), and are copied into the NuGet package during the packing process.
- **Packing process** is the process of creating the NuGet package from the compiled project. This is done by running
  the `dotnet pack` command, which uses the project's `.csproj` file to determine what files to include in the package.
  You could also use a dedicated `.nuspec` file and the `nuget pack` command, but I will not be covering that here.

### Step 1: Include asset files in the compiled project

In Project A folder, we have created a folder called "assets" that contains the necessary JSON files.

In Project A's `.csproj` file, we add the following line inside the root `<Project>` tag:

```xml

<ItemGroup>
    <Content Include="assets\**\*.*" Pack="true" PackagePath="contentFiles/assets">
        <PackageCopyToOutput>true</PackageCopyToOutput>
    </Content>
</ItemGroup>
```

The `<Content>` tag tells the build process to include the specified file(s) in the compiled project. Here, the
path `assets\**\*.*` means I am including every file and subdirectory inside the `assets` folder. The build process
will look for the `assets` folder in the same directory as the `.csproj` file, so I don't need to specify a full path.

For now, we can ignore the `Pack` and `PackagePath` attributes. The `PackageCopyToOutput` attribute tells the build
process
to copy the asset files to the compiled project's output directory. With this configuration, the `assets` folder will be
copied one-to-one to the compiled project's `bin/` directory, meaning the path to the JSON files will be `bin/assets/`.
This is important for how I am accessing these files in my code:

    ```csharp
    var relativePath = "assets/my_file.json";
    var fullPath = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), $@"{relativePath}");
    ```

### Step 2: Include asset files in the NuGet package

Because we are not using an explicit `.nuspec` file, the `.csproj` file is pulling double duty here in also defining how
our NuGet package will be generated. That's where the `Pack` and `PackagePath` attributes in the code snippet above come
in.

The `Pack` attribute tells the build process to include the specified file(s) in the NuGet package when
the `dotnet pack` command is run.

The `PackagePath` attribute tells the build process where to place the specified file(s) in the NuGet package. Alex
Yumashev gives a good explanation of the NuGet file structure
in [his blog post](https://www.jitbit.com/alexblog/303-nuget-authoring-copying-content-files-into-you-project-folder/),
although he is using a `.nuspec` file. The `contentFiles` folder is a special folder that NuGet uses to store files
that will be imported into the end user's project. We want to copy our `assets` folder to `contentFiles/assets` in the
NuGet package, so that when the end user installs our package, the `assets` folder will be available in their project.

### Step 3: Import asset files into the end user's project

The problem with this current configuration is that the `assets` folder will be copied into their project's source code,
which a) may reveal files that you don't want to be publicly visible, and b) may cause conflicts with other files in
their project, or even cause their project to not compile correctly as a result (as was the case for me; the JSON files
were being included pre-compile, and the compiler was complaining that they weren't valid C# code).

That's where Step 3 comes in, to delay this process.

In Project A's `.csproj` file, we add the following line inside the same `<ItemGroup>` tag as before:

```xml
  <!-- Instructions that will be executed by the downstream project using this NuGet package -->
<Content Include="Project-A.targets" PackagePath="build/Project-A.targets"/>
```

This line tells the build process to include the `Project-A.targets` file in the NuGet package.

In Project A, we create a `Project-A.targets` file at the root level of the project (i.e. in the same directory as the
`.csproj` file). This file contains the following code:

```xml

<Project>
    <ItemGroup>
        <Files Include="$(MSBuildThisFileDirectory)/../contentFiles/assets/**/*.*"/>
    </ItemGroup>
    <!-- Copy asset files from this NuGet package to the output directory of the downstream project after build -->
    <Target Name="CopyFiles" AfterTargets="Build">
        <Copy SourceFiles="@(Files)" DestinationFolder="$(TargetDir)/assets/%(RecursiveDir)"/>
    </Target>
</Project>
```

These instructions, when read by Project B, will tell the build process to copy the `assets` folder from the NuGet
package to the output directory of Project B, but only after the compile process has completed. This will make the
`assets` folder available to Project B at runtime, but not interfere Project B's compile process. It also means that
the `assets` folder will not be copied into Project B's source code, making it less visible to the end user (it is still
visible inside Project B's `bin/` directory after compilation, but the end user is not likely looking at the files in
that folder).

Looking at the code snippet, let's highlight a few things:

- The `<Files>` tag is not a defined tag name. You can realistically name this whatever you want, as long as you use the
  same name when referring to it in the `SourceFiles` attribute of the `<Copy>` tag later on.
- The name of the `Project-A.targets` file must match exactly the Package ID of the NuGet package (not the assembly name
  or root namespace).
    - For example, your Project A's `.csproj` file may have the following line:
      ```xml
      <PropertyGroup>
          <AssemblyName>ProjectA</AssemblyName>
          <RootNamespace>ProjectA.NameSpace</RootNamespace>
          <PackageId>Project-A</PackageId>
      </PropertyGroup>
      ```
      In this case, the `Project-A.targets` file must be named `Project-A.targets`, not `ProjectA.targets`
      or `ProjectA.NameSpace.targets`.
- You'll notice the path of the `Files` tag looks a little odd. It's basically telling the build process to start at the
  current directory of the NuGet package it's using (i.e. the `build` folder inside the NuGet package where the DLL from
  Project A is stored), go up one directory to the root of the NuGet package, and then go into the `contentFiles`
  folder. From there, we want it to copy every file and subdirectory inside the `assets` folder, so we use the `**/*.*`.
  The `DestinationFolder` attribute of the `<Copy>` tag is telling the build process to copy these files and
  subdirectories to an `assets` folder inside the output directory of Project B.
  The `%(RecursiveDir)` part is a special attribute that tells the build process to copy the subdirectories as well.

With this configuration, when Project B is compiled, the `assets` folder will be available in the output directory the
same way it was for Project A in Step 1, allowing Project B to access the JSON files.

## Conclusion

When it's all said and done, your final configuration should look something like this:

### Project A's `.csproj` file

```xml

<ItemGroup>
    <!-- Asset files -->
    <Content Include="assets\**\*.*" Pack="true" PackagePath="contentFiles/assets">
        <PackageCopyToOutput>true
        </PackageCopyToOutput> <!-- Copy to output directory when built locally, so can be used for testing -->
    </Content>
    <!-- Instructions that will be executed by the downstream project using this NuGet package -->
    <Content Include="Project-A.targets" PackagePath="build/Project-A.targets"/>
</ItemGroup>
```

### Project A's `Project-A.targets` file

```xml

<Project>
    <ItemGroup>
        <Files Include="$(MSBuildThisFileDirectory)/../contentFiles/assets/**/*.*"/>
    </ItemGroup>
    <!-- Copy asset files from this NuGet package to the output directory of the downstream project after build -->
    <Target Name="CopyFiles" AfterTargets="Build">
        <Copy SourceFiles="@(Files)" DestinationFolder="$(TargetDir)/assets/%(RecursiveDir)"/>
    </Target>
</Project>
```

### Project B's `.csproj` file

```xml

<ItemGroup>
    <!-- Add reference to Project A's NuGet package -->
    <PackageReference Include="Project-A" Version="1.0.0"/>
</ItemGroup>
```

You'll notice that Project B simply has to add Project A's NuGet package as a dependency. This is important because it
means no extra configuration required to get your NuGet package working in the end user's project.

## Credits

Thank you to all the various StackOverflow posts, GitHub issues and blogs that helped me figure this out. In particular, I'd like to highlight:

- Alex Yumashev's [blog post](https://www.jitbit.com/alexblog/303-nuget-authoring-copying-content-files-into-you-project-folder/)
- Tony Sneed's [blog post](https://blog.tonysneed.com/2021/12/04/copy-nuget-content-files-to-output-directory-on-build/)
- Newbedev's [blog post](https://newbedev.com/copy-files-from-nuget-package-to-output-directory-with-msbuild-in-csproj-and-dotnet-pack-command)
