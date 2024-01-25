def _compile_files_impl(ctx):
    outputs = []
    for file in ctx.files.srcs:
        output = ctx.actions.declare_file("{}_output".format(file.path))
        outputs.append(output)
        ctx.actions.run(
            tools = [ctx.executable.tool],
            executable = ctx.executable.tool,
            inputs = depset(ctx.files.srcs),
            outputs = [output],
            arguments = [file.path, output.path],
        )
    return [DefaultInfo(files = depset(outputs))]


compile_files = rule(
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
        ),
        "tool": attr.label(
            executable = True,
            cfg = "exec",
        ),
    },
    implementation = _compile_files_impl,
)