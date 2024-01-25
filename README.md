```
./write.sh a
```

```
bazel --ignore_all_rc_files cquery --transitions=lite '//...'
```
produces
```
//:first (102280f)
  srcs#//:src/file1#NullTransition ->
  tool#//:normal_compiler#NoTransition ->
//:first (312a038)
  srcs#//:src/file1#NullTransition ->
  tool#//:normal_compiler#(exec + (TestTrimmingTransition + ConfigFeatureFlagTaggedTrimmingTransition)) -> 102280f
//:normal_compiler (102280f)
  srcs#//:compiler.sh#NullTransition ->
  $launcher#@bazel_tools//tools/launcher:launcher#NoTransition ->
//:normal_compiler (312a038)
  srcs#//:compiler.sh#NullTransition ->
  $launcher#@bazel_tools//tools/launcher:launcher#(exec + (TestTrimmingTransition + ConfigFeatureFlagTaggedTrimmingTransition)) -> 102280f
//:second (312a038)
  srcs#//:src/file2#NullTransition ->
  tool#//:wrapped_compiler#(exec + (TestTrimmingTransition + ConfigFeatureFlagTaggedTrimmingTransition)) -> 102280f
//:wrapped_compiler (102280f)
  data#//:first#NoTransition ->
  srcs#//:compiler.sh#NullTransition ->
  $launcher#@bazel_tools//tools/launcher:launcher#NoTransition ->
//:wrapped_compiler (312a038)
  data#//:first#NoTransition ->
  srcs#//:compiler.sh#NullTransition ->
  $launcher#@bazel_tools//tools/launcher:launcher#(exec + (TestTrimmingTransition + ConfigFeatureFlagTaggedTrimmingTransition)) -> 102280f
```

```
bazel --ignore_all_rc_files build //...
```
shows
```
    Action src/file1_output; 2s linux-sandbox
    Action src/file1_output [for tool]; 2s linux-sandbox
```

Since the target and exec platforms are identical, I would expect the actions to not be duplicated "[for tool]"

Should I just be using `cfg = "target"` everywhere instead?