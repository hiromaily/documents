# Development, Stage, Production環境を作成する

## DynamoDB

1. **各環境ごとに`異なるテーブル名`を用意し、命名規則を利用して環境を分ける**

   - myapp-dev-table
   - myapp-stage-table
   - myapp-prod-table

## Lambda

1. **各環境ごとに`異なるLambda関数`を用意し、命名規則を利用して環境を分ける**

   - myapp-dev-my-function
   - myapp-stage-my-function
   - myapp-prod-my-function

## Amazon ECS

1. **環境毎に別の`ECSクラスター`を作成する**

   - myapp-dev-cluster
   - myapp-stage-cluster
   - myapp-prod-cluster

2. **クラスターごとのタスク定義**： 各クラスターにデプロイされるサービスには、それぞれのクラスター専用のタスク定義を使用する。タスク定義には環境固有の設定（例：環境変数やリソース制限）を記述する。

## CloudWatchによるLogのフィルタリング

ECSでは、タスクやサービスからのログをCloudWatchに送信する設定ができる

1. **環境ごとのロググループ： 各環境ごとに異なるロググループを設定・使用する**

    ```sh
    aws logs create-log-group --log-group-name /ecs/myapp/dev
    aws logs create-log-group --log-group-name /ecs/myapp/stage
    aws logs create-log-group --log-group-name /ecs/myapp/prod
    ```

2. **ECSタスク定義のログ設定で、対応するロググループを指定する**

    ```json
    {
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "/ecs/myapp/stage",
                "awslogs-region": "us-west-1",
                "awslogs-stream-prefix": "ecs"
            }
        }
    }
    ```

3. **タスク定義で環境別設定**： 各タスク定義において環境変数やラベルを使用して、より詳細なログフィルタリングが行えるようにする

    ```json
    {
        "family": "myapp-stage-task",
        "containerDefinitions": [
            {
                "name": "myapp-container",
                "image": "myapp-image:latest",
                "logConfiguration": {
                    "logDriver": "awslogs",
                    "options": {
                        "awslogs-group": "/ecs/myapp/stage",
                        "awslogs-region": "us-west-2",
                        "awslogs-stream-prefix": "ecs"
                    }
                },
                "environment": [
                    {
                        "name": "ENVIRONMENT",
                        "value": "stage"
                    }
                ]
            }
        ]
    }
    ```
