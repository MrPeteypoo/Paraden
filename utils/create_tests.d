#!/usr/bin/rdmd
import std.experimental.all;

immutable sourceSubdirectory = "source";
immutable testSubdirectory = "tests";
immutable testSuffix = "_tests";

void main()
{
    immutable sourcePath = getcwd().buildPath(sourceSubdirectory);
    sourcePath.dirEntries("*.d", SpanMode.depth)
        .filter!(source => source.baseName != "package.d")
        .each!(source => createTestFile(source.relativePath(sourcePath)));
}

void createTestFile(T)(auto ref T sourcePath)
{
    auto testPath = sourcePath.asTestPath;
    if (!testPath.exists)
    {
        testPath.dirName.mkdirRecurse;
        std.file.write(testPath, buildModuleContents(sourcePath, testPath));
        writeln("Created: ", testPath);
    }
}

auto asTestPath(T)(auto ref T source)
in
{
    assert(source.isValidPath, "Given source must be a valid path.");
}
out(testPath)
{
    assert(testPath.isValidPath, "Generated path not valid.");
}
do
{
    return buildPath
    (
        testSubdirectory, 
        source.dirName, 
        setExtension(source.baseName.stripExtension ~ testSuffix, ".d")
    );
}

string buildModuleContents(T1, T2)(auto ref T1 sourcePath, auto ref T2 testPath)
{
    return testPath.asModuleDeclaration ~ sourcePath.asImportDeclaration ~ "\n";
}

string asModuleDeclaration(T)(auto ref T source)
{
    return "module " ~ source.asModuleName ~ ";\n";
}

string asImportDeclaration(T)(auto ref T source)
{
    return "import " ~ source.asModuleName ~ ";\n";
}

string asModuleName(T)(auto ref T source)
{
    return source.dirName
        .buildPath(source.baseName.stripExtension)
        .pathSplitter
        .strip(testSubdirectory)
        .join(".");
}