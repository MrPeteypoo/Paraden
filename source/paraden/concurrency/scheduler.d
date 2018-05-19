module paraden.concurrency.scheduler;

import core.sync.mutex : Mutex;
import std.concurrency : Scheduler, ThreadInfo;

import paraden.concurrency.condition : Condition;
import paraden.concurrency.fiber : Fiber;
import paraden.concurrency.thread : Thread;

class JobScheduler : Scheduler
{
    private Thread[] threads;
    private Fiber[] fibers;
    
    override 
    void start(void delegate() func)
    {
        
    }

    override
    void spawn(void delegate() func)
    {

    }

    override 
    void yield() nothrow
    {

    }

    override nothrow @property
    ref ThreadInfo thisInfo()
    {
        return ThreadInfo.thisInfo;
    }

    override nothrow
    Condition newCondition(Mutex mutex)
    {
        return new Condition(mutex);
    }
}