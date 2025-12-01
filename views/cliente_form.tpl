% rebase('layout.tpl', title='Perfil do Cliente')

<style>
    .error-message {
        background-color: #ffe5e5;
        color: #c0392b;
        padding: 12px;
        border-radius: 6px;
        margin-bottom: 20px;
        border: 1px solid #f5c6cb;
        font-size: 14px;
    }
</style>

<section class="page-section">
    <div class="form-container">
        
        <div class="form-header">
            <h1 class="section-title">
                <i class="fas fa-user"></i> Dados do Cliente
            </h1>
            <p class="form-subtitle">Complete seu cadastro para alugar veículos.</p>
        </div>

        % if defined('error') and error:
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> {{error}}
        </div>
        % end
        <form action="/cliente/perfil" method="post" class="styled-form">

            <div class="form-group">
                <label>Nome Completo</label>
                <input type="text" name="name" required
                       value="{{cliente.name if cliente else ''}}">
            </div>

            <div class="form-group">
                <label>CPF</label>
                <input type="text" name="cpf" required
                       value="{{cliente.cpf if cliente else ''}}" placeholder="Apenas números (11 dígitos)">
            </div>

            <div class="form-group">
                <label>Telefone</label>
                <input type="text" name="telephone" required
                       value="{{cliente.telephone if cliente else ''}}" placeholder="Apenas números">
            </div>

            <div class="form-group">
                <label>Endereço Completo</label>
                <input type="text" name="endereco" required
                       value="{{cliente.endereco if cliente else ''}}">
            </div>

            <button type="submit" class="btn btn-primary form-submit">
                <i class="fas fa-save"></i> Salvar e Ver Carros
            </button>
        </form>

    </div>
</section>