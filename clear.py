import os
import shutil

def delete_folders(path):
    for root, dirs, files in os.walk(path, topdown=False): 
        for dir_name in dirs:
            if dir_name == ".dart_tool" or dir_name == "build" or dir_name == "ephemeral":
                folder_path = os.path.join(root, dir_name)
                print(f"Deleting {folder_path}")
                shutil.rmtree(folder_path)

if __name__ == "__main__":
    root_directory = input("Enter the root directory where your Flutter projects are located: ")

    if not os.path.exists(root_directory):
        print("Directory does not exist.")
    else:
        # Recursively delete .dart_tool, build folders and ephemeral folder in windows/flutter
        delete_folders(root_directory)
