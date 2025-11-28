from bottle import static_file


class BaseController:
    #constructor 
    def __init__(self, app):
        self.app = app
        self._setup_base_routes()

    #_setup... é um método interno, protegido, 
    def _setup_base_routes(self):
        """Configura rotas básicas comuns a todos os controllers"""
        #/ é a raiz do site, parte principal tipo www.exemplosite.com/, o GET seria o endereço digitado ou escolhido
        #callback = self.home_redirect basicamente salva o endereço da home e volta quando o usuário solicitar (não entendi tão bem)
        self.app.route('/', method='GET', callback=self.home_redirect)
        #/helper agora é a raiz do site + helper, e o callback seria voltar o helper se o usuário desejar
        self.app.route('/helper', method=['GET'], callback=self.helper)

        # Rota para arquivos estáticos (CSS, JS, imagens), se eu entendi isso é a rota de onde tá arquivos de imagens, ai ele pega ai
        self.app.route('/static/<filename:path>', callback=self.serve_static)

    #se alguém deixar o site raiz sem nada ou só /, ele redireciona para /users
    def home_redirect(self):
        """Redireciona a rota raiz para /users"""
        return self.redirect('/users')

    #carrega o arquivo tpl 'helper-final' se é digitado helper
    def helper(self):
        return self.render('helper-final')


    def serve_static(self, filename):
        """Serve arquivos estáticos da pasta static/"""
        #filename é o nome do arquivo , root define que o servidor só pode ler arquivos dentro da pasta static
        return static_file(filename, root='./static')

    def render(self, template, **context):
        """Método auxiliar para renderizar templates"""
        #aqui o render pega a função template do bottle, template é um arquivo tpl/html em branco com espaços 
        #de variáveis para serem usados, o **context permite passar dados python para html e preencher esses espaços
        from bottle import template as render_template
        return render_template(template, **context)


    def redirect(self, path, code=302):
        """Redirecionamento robusto com tratamento de erros"""
        from bottle import HTTPResponse, response as bottle_response
        #redirecionamento caso tenha algo errado code 302, que é um caminho temporariamente indisponivel
        try:
            #se der ele vai dar code 302 e mostrar o endereço path, carregando a nova página
            bottle_response.status = code
            bottle_response.set_header('Location', path)
            return bottle_response
        except Exception as e:
            #se não der vai dar erro no redirect e dar status 200
            print(f"ERRO NO REDIRECT: {type(e).__name__} - {str(e)}")
            return HTTPResponse(
                body=f'<script>window.location.href="{path}";</script>',
                status=200,
                headers={'Content-Type': 'text/html'}
            )
