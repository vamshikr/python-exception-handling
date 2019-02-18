import sys
import json


def get_pkg_name(filepath, number):

    with open(filepath) as fp:
        data = json.load(fp)

        for pkg_info in data['rows'][:number]:
            yield pkg_info['project']

            
def main(filepath, number):
    for pkg_name in get_pkg_name(filepath, number):
        print(pkg_name)


if __name__ == '__main__':
	main(sys.argv[1], int(sys.argv[2]))
