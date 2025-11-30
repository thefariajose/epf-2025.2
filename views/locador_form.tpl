% rebase('layout.tpl', title='Perfil do Locador')

<section class="form-section">

    <div class="form-container-box modern-box">

        <div class="form-header">
            <h1><i class="fas fa-user-tie"></i> Perfil do Locador</h1>
            <p>Complete seus dados para gerenciar sua frota e disponibilizar veículos para aluguel.</p>
        </div>

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
                    placeholder="(XX) 99999-9999">
            </div>

            <div class="form-group">
                <label>CNPJ (ou CPF)</label>
                <input type="text" name="cnpj" required
                    value="{{locador.cnpj if locador else ''}}"
                    placeholder="00.000.000/0001-00">
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> Salvar Perfil
            </button>

        </form>

    </div>

</section>
