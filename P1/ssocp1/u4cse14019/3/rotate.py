import sys

if len(sys.argv) == 2:
    string = sys.argv[1]
    reverse = ""

    for i in range(len(string)):
	reverse = reverse + string[len(string) - i - 1]

    print reverse
