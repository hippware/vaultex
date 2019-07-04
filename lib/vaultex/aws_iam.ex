defmodule Vaultex.Auth.AWSIAM do

  @url "https://sts.amazonaws.com"
  @body "Action=GetCallerIdentity&Version=2011-06-15"

  def credentials(config, server) do
    %{
      iam_http_request_method: "POST",
      iam_request_url: Base.encode64!(@url),
      iam_request_body: Base.encode64!(@body),
      iam_request_headers: Base.encode64!(request_headers(config, server))
    }
  end

  def request_headers(config, server) do
    base_headers = [
      {"User-Agent", "ExAws"},
      {"X-Vault-awsiam-Server-Id", server},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]

    {:ok, headers} = ExAws.Auth.headers(:post, @url, base_headers, :sts, config, headers, @body)
    headers
  end
end
