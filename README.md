# MyCounter

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


podman run -it --network host -e "ERL_AFLAGS=-setcookie 'abc123'" counter_web  iex --name myapp@127.0.0.1 -S mix phx.server

podman run -it -p 4001:4000  -e "ERL_AFLAGS=-setcookie 'abc123' -kernel prevent_overlapping_partitions false" counter_web  iex --name myapp@127.0.0.1 -S mix phx.server

aws ecr create-repository \
    --repository-name repo \
    --image-tag-mutability IMMUTABLE \
    --image-scanning-configuration scanOnPush=true \
    --encryption-configuration encryptionType=KMS,kmsKey=alias/aws/ecr \
    --region us-west-2

kubectl create secret docker-registry my-ecr-secret \
  --docker-server=211125762589.dkr.ecr.us-west-2.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --region us-west-2) \

kubectl get services -o wide