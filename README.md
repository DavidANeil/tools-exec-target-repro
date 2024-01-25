```
./write.sh a
```

```
bazel --ignore_all_rc_files cquery --transitions=lite '//...'
```

```
bazel --ignore_all_rc_files build //...
```

Since the target and exec platforms are identical, I would expect the actions to not be duplicated "[for tool]"

Should I just be using `cfg = "target"` everywhere instead?