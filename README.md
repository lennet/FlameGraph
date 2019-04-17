# FlameGraph

Work in Progress 

A CommandLine tool to generate FlameGraphs from Xcode Instruments traces

##Usage

1. Run Time Profiler in Instruments
2. Select Thread you are interested int 
3. Edit > Deep copy
4. Save copied content to a file 
5.
```
$ swift build
$ ./.build/debug/FlameGraph <Input path> <OutputPath.png>
```