TestTimes
=========

Get a report of test times when running ```mix test --times```. Slowest tests appear at the bottom.

### Sample report

```
 t(ms) |                                              test path | test name 
======================================================================================
 19651 |        test/controllers/profile_controller_test.exs:17 | shows a number of cr
 21045 |      test/controllers/character_controller_test.exs:42 | create creates a cha
 21217 | test/controllers/password_reset_controller_test.exs:38 | submit_request shows
 22431 |       test/controllers/vehicle_controller_test.exs:407 | update re-renders th
 22907 |         test/controllers/signup_controller_test.exs:19 | welcome renders the 
 25079 |       test/controllers/vehicle_controller_test.exs:320 | update updates child
 25694 |     test/controllers/character_controller_test.exs:177 | create respects the 
 44538 | test/controllers/password_reset_controller_test.exs:20 | submit_request email
 50810 |     test/controllers/character_controller_test.exs:155 | create re-renders th
 70055 |     test/controllers/character_controller_test.exs:546 | update re-renders th
331136 |         test/controllers/signup_controller_test.exs:52 | signup renders an er
334917 |         test/controllers/signup_controller_test.exs:99 | login displays an er
```

### Usage

Add a dependency in ```mix.exs```:

```{:test_times, "~> 1.0.0"}```

Add a line to ```test/test_helper.exs``` before the call to ```ExUnit.start```:

```elixir
TestTimes.setup
```

When you want a report of times, use the ```--times``` flag

```
$ mix test --times
```

