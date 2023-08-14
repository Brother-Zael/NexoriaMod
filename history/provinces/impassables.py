import os

# Function to replace content if 'is_city = no' is found
def replace_content(filename):
    with open(filename, 'r') as f:
        content = f.read()
        
        if 'is_city = no' in content:
            with open(filename, 'w') as f_out:
                f_out.write("#\nis_city = no\ndiscovered_by = western\n")

# Set the directory path to the location of this script
directory_path = os.path.dirname(os.path.abspath(__file__))

# Walking through the directory and checking each .txt file
for foldername, subfolders, filenames in os.walk(directory_path):
    for filename in filenames:
        if filename.endswith('.txt'):
            filepath = os.path.join(foldername, filename)
            replace_content(filepath)

print("Done!")