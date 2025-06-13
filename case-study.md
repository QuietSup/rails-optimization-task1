# Optimization Case-study 

## Current Problem 
The program worked well for small files, but it was too slow and we're not sure if it will finish in a reasonable time.

I decided to fix this problem, optimizing this program.

## Metric 
As the metric I used the time it takes to process a sample of 30k lines.

## Optimized Program Correctness Guarantee
The program has a test. Executing this test in the feedback-loop does not allow changes in the logic of the program during optimization.

## Feedback-Loop
- use a sample of 30k lines whick is processed for 24 seconds
- find the growth point using the profiler
- optimize it 
- check if the sample is processed faster
- run tests 

## Finding the Growth Point
To find the growth point I used stackprof as a profiler.

### Problem #1
- какой отчёт показал главную точку роста
- как вы решили её оптимизировать
- как изменилась метрика
- как изменился отчёт профилировщика - исправленная проблема перестала быть главной точкой роста?

The main growth point is sessions.select

Attempt #1
Every time it searches through all the records. But records are unique for each user, so we can delete it on every iteration. I replaced `select` with `reject!`

It takes 14 seconds to process 30k lines.

Attempt #2
I used `group_by` to group sessions by user_id.

Now it takes 3 seconds to process 30k lines!

The problem is no longer the growth point ^^

Let's change the number of records to 300k to see the difference for next problems. It takes 10 seconds.

### Problem #2
The next growth point is Arra#each and Array#all? when filtering unique browsers.

Attempt #1
I used `Set` to filter unique browsers.

It takes 8 seconds to process 300k lines.

Attempt #2 
I used `uniq` to filter unique browsers.

It also takes 8 seconds to process 300k lines, but looks better: takes only 1 line of code.

The speed improvement is not big, but it's still some improvement... 

## Results
Now it takes only 8 seconds to process the data_large.txt file (3250940 lines).

