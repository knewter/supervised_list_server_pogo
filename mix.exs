Code.append_path "_build/shared/lib/relex/ebin/"
Code.append_path "_build/shared/lib/pogo/ebin/"

if Code.ensure_loaded?(Relex.Release) do
  defmodule SupervisedListServer.Release do
    use Relex.Release
    use Pogo.Release

    def name, do: "supervised_list_server"
    def applications, do: [:supervised_list_server]
  end
end

defmodule SupervisedListServer.Mixfile do
  use Mix.Project

  def project do
    [ app: :supervised_list_server,
      version: "0.0.1",
      elixir: "~> 0.11.3-dev",
      elixirc_options: options(Mix.env),
      deps: deps,
      release: SupervisedListServer.Release
    ]
  end

  def options(env) when env in [:dev, :test] do
    [exlager_level: :debug]
  end

  def options(env) when env in [:prod] do
    [exlager_level: :warning]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [
        :exlager
      ],
      mod: { SupervisedListServer, [] }
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:exlager, github: "khia/exlager"},
      {:relex, github: "interline/relex", branch: "start_clean"},
      {:pogo, github: "onkel-dirtus/pogo"}
    ]
  end
end
