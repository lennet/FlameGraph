# FlameGraph

Work in Progress 

A CommandLine tool to generate FlameGraphs from Xcode Instruments traces

An example FlameGraph for the ```-[AppDelegate application:didFinishLaunchingWithOptions:]``` method of the Wikipedia iOS App:
![Example output](example/output.png)


## Installation

### [Mint](https://github.com/yonaskolb/mint)
```
$ mint install lennet/FlameGraph
```

### Swift Package Manager
```
$ git clone https://github.com/lennet/FlameGraph.git
$ cd FlameGraph
$ swift run FlameGraph <args>
```

## Usage

1. Run Time Profiler in Instruments
2. Select Thread and region you are interested in
3. Edit > Deep copy ⇧⌘C
4. ```$ FlameGraph <OutputPath.png>```
