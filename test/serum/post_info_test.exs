defmodule PostInfoTest do
  use ExUnit.Case, async: true
  alias Serum.SiteBuilder
  alias Serum.PostInfo

  setup do
    null = spawn_link __MODULE__, :looper, []
    {:ok, pid} = SiteBuilder.start_link "#{priv()}/testsite_good", ""
    Process.group_leader pid, null
    SiteBuilder.load_info pid
    send null, :stop
    on_exit :clean, fn -> SiteBuilder.stop pid end
    {:ok, [builder: pid]}
  end

  test "new/4", ctx do
    Process.link ctx[:builder]
    info = PostInfo.new(
      "2017-02-04-1948-test-post",
      {"Test Post", [], []},
      {{2017, 2, 4}, {19, 48, 0}},
      "Hello, world!"
    )
    expected = %PostInfo{
      file: "2017-02-04-1948-test-post",
      title: "Test Post",
      tags: [],
      preview_text: "Hello, world!",
      raw_date: {{2017, 2, 4}, {19, 48, 0}},
      date: "Saturday, 4 Feb 2017",
      url: "/test_base/posts/2017-02-04-1948-test-post.html"
    }
    assert expected == info
  end

  defp priv, do: :code.priv_dir :serum

  def looper do
    receive do
      {:io_request, from, reply_as, _} when is_pid(from) ->
        send from, {:io_reply, reply_as, :ok}
        looper()
      :stop -> :stop
      _ -> looper()
    end
  end
end
