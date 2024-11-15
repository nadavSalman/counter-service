import os
from flask import current_app


class CounterIOHandler:
    def __init__(self, file_name="counter.txt"):
        self.file_path = os.path.join(os.getcwd(), file_name)
        
        if not os.path.exists(self.file_path):
            self.write(0)  

    def read(self):
        if os.path.exists(self.file_path):
            with open(self.file_path, "r") as f:
                try:
                    # current_app.logger.info("Successfully read counter file {self.file_path}")
                    print("Successfully read counter file {self.file_path}")
                    return int(f.read()) # str -> int ...
                except Exception as e:
                    # current_app.logger.info(f"Failed to read counter file {self.file_path}, error : {ValueError}")
                    print(f"Failed to read counter file {self.file_path}, error : {ValueError}")
                    return 0
        return 0

    def write(self, value):
        try:
            with open(self.file_path, "w") as f:
                f.write(str(value))
            # current_app.logger.info(f"Successfully wrote value {value} to counter file {self.file_path}")
            print(f"Successfully wrote value {value} to counter file {self.file_path}")
        except Exception as e:
            # current_app.logger.error(f"Failed to write to counter file {self.file_path}, error: {str(e)}")
            print(f"Failed to write to counter file {self.file_path}, error: {str(e)}")