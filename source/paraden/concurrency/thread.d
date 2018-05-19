module paraden.concurrency.thread;

import core.thread : CoreThread = Thread;
import std.stdio : writeln;

class Thread : CoreThread
{
    this()
    {
        super(&run);
    }

    void run()
    {
        writeln("Thread running.");
    }
}