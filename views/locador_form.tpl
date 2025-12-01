% rebase('layout.tpl', title='Perfil do Locador')

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

<section class="form-section">

    <div class="form-container-box modern-box">

        <div class="form-header">
            <h1><i class="fas fa-user-tie"></i> Perfil do Locador</h1>
            <p>Complete seus dados para gerenciar sua frota e disponibilizar veículos para aluguel.</p>
        </div>

        % if defined('error') and error:
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> {{error}}
        </div>
        % end
        <form action="/locador/perfil" method="post">

            <div class="form-group">
                <label>Nome Completo (ou Razão Social)</label>
                <input type="text" name="name" required
                    value="{{locador.name if locador else ''}}"
                    placeholder="Ex: João da Silva ou Locadora XPTO">
            </div>

            <div class="form-group">
                <label>Telefone / WhatsApp</label>
                <input type="text" name="telephone" required
                    value="{{locador.telephone if locador else ''}}"
                    placeholder="(XX) 999999999 (apenas números)">
            </div>

            <div class="form-group">
                <label>CNPJ </label>
                <input type="text" name="cnpj" required
                    value="{{locador.cnpj if locador else ''}}"
                    placeholder="Apenas números (14 dígitos)">
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> Salvar Perfil
            </button>

        </form>

    </div>

</section>