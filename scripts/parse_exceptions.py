import sys
import ast


class ExceptionVisitor(ast.NodeVisitor):

    def __init__(self):
        self.in_exception_handler = False
    
    def visit_ExceptHandler(self, node):
        if isinstance(node.type, ast.Name):
            print('Expection Type:: ' + node.type.id)
        elif isinstance(node.type, ast.Attribute):
            print('Expection Type:: ' + node.type.value.id + '.' + node.type.attr)
        elif isinstance(node.type, ast.Tuple):
            for exp in node.type.elts:
                if isinstance(exp, ast.Name):
                    print('Expection Type:: ' + exp.id)
                elif isinstance(exp, ast.Attribute):
                    print('Expection Type:: ' + exp.value.id + '.' + exp.attr)
        else:
            print(node.type)                

        self.in_exception_handler = True
        self.generic_visit(node)
        self.in_exception_handler = False


    def visit_Raise(self, node):
        
        if self.in_exception_handler:

            if isinstance(node.exc, ast.Call):
                print('Reraise:: ' + node.exc.func.id)
            elif isinstance(node.exc, ast.Name):
                print('Reraise:: ' + node.exc.id)
            else:
                pass #print('Reraise:: ' + node)

        self.generic_visit(node)


def main(fileset):

    exp_visitory = ExceptionVisitor()

    for filepath in fileset:
    
        with open(filepath, encoding='utf-8') as fp:
            code = fp.read()
            try:
                tree = ast.parse(code)
                exp_visitory.visit(tree)        
            except AttributeError as err:
                print(err)


if __name__ == '__main__':
    main(sys.argv[1:])
