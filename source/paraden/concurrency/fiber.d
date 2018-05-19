module paraden.concurrency.fiber;

import core.thread : CoreFiber = Fiber;
import std.stdio : writeln;

class Fiber : CoreFiber
{
    this()
    {
        super(&run); 
    }

    void run()
    {
        writeln("Fiber running.");
    } 
}