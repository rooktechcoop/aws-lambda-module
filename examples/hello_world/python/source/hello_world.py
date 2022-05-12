import json
import Config


def lambda_handler(event, context):
    # TODO implement
    return {"statusCode": 200, "body": json.dumps(f"Hello {Config.GREET} from Lambda!")}
