ExUnit.configure(formatters: [ExUnit.CLIFormatter, ExUnitNotifier])
ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)
