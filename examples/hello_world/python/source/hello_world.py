import os
import json
import Config


# def lambda_handler(event, context):
#     # TODO implement
#     return {"statusCode": 200, "body": json.dumps(f"Hello {Config.GREET} from Lambda!")}

# def lambda_handler(event, context):
#     return "{} from Lambda!".format(os.environ['greeting'])

def lambda_handler (event, context):
        print (os.environ.get('greeting')) #One way.
        print (Config.GREET) #Other way.
        return {"statusCode": 200, "body": json.dumps(f"Hello {Config.GREET} from Lambda! v3")}
