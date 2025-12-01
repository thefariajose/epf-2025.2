% rebase('layout.tpl', title='Veículos Disponíveis')

<style>
    /* Variáveis da Marca CarRENT (Azul Marinho e Laranja) */
    :root {
        --primary-color: #163b65; 
        --accent-color: #e67e22;  
        --success-color: #27ae60;
    }

    /* Estilo Específico para o Card de Veículo */
    .car-card {
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0,0,0,0.08); /* Sombra mais destacada */
        border: 1px solid var(--border-color);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .car-card:hover {
        transform: translateY(-5px); /* Efeito 3D sutil no hover */
        box-shadow: 0 8px 15px rgba(0,0,0,0.12);
    }

    .car-image-placeholder {
        height: 180px;
        background-color: var(--light-gray); /* Cinza claro */
        display: flex;
        align-items: center;
        justify-content: center;
        color: #999;
        font-size: 2rem;
    }

    .car-details {
        padding: 20px;
    }

    .car-details h3 {
        margin: 0 0 5px 0;
        color: var(--primary-color);
        font-size: 1.5rem;
    }

    .car-details small {
        color: #777;
        font-weight: 500;
        font-size: 0.95rem;
        display: block;
    }

    .car-info-line {
        margin: 10px 0;
        font-size: 14px;
        color: #666;
    }

    .car-info-line i {
        color: #aaa;
        margin-right: 5px;
    }

    .car-price {
        font-size: 24px;
        font-weight: 700;
        color: var(--accent-color); /* Preço em Laranja */
    }

    .car-price small {
        font-size: 0.75em;
        font-weight: 500;
        color: #999;
    }

    .btn-alugar {
        background-color: var(--primary-color);
        color: white !important;
        padding: 10px 20px;
        border-radius: 6px;
        font-weight: 600;
        text-decoration: none;
        transition: 0.2s ease;
    }

    .btn-alugar:hover {
        background-color: var(--accent-color);
    }

    /* Layout da grade */
    .car-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 30px;
        margin-top: 30px;
    }

    /* Header de Boas-vindas */
    .welcome-info {
        display: flex;
        align-items: center;
        gap: 15px;
        font-size: 1rem;
        color: #555;
    }

    .welcome-info a {
        color: var(--primary-color);
        text-decoration: none;
        font-weight: 600;
    }
    
    .welcome-info a:hover {
        text-decoration: underline;
    }
</style>

<section class="car-catalogue">
    <div class="section-header">
        <h1 class="section-title"><i class="fas fa-car-side" style="color: var(--accent-color);"></i> Veículos Disponíveis</h1>
        
        <div class="welcome-info">
            <span>Olá, **{{cliente.name}}**!</span> 
            | <a href="/cliente/perfil"><i class="fas fa-user-edit"></i> Editar Perfil</a> 
            | <a href="/cliente/meus_alugueis" style="color: var(--accent-color);"><i class="fas fa-receipt"></i> Meus Aluguéis</a>
        </div>
    </div>

    <div class="car-grid">
        
        % for carro in carros:
        <div class="car-card">
            <div class="car-image-placeholder">
                <i class="fas fa-car fa-3x"></i>
            </div>
            
            <div class="car-details">
                <h3>{{carro.modelo}}</h3>
                <small>{{carro.marca}}</small>
                
                <div class="car-info-line">
                    <i class="fas fa-calendar"></i> {{carro.ano}} 
                    <span style="margin: 0 10px;">|</span> 
                    <i class="fas fa-tachometer-alt"></i> {{carro.quilometragem}} km
                </div>
                
                <hr style="border: none; border-top: 1px solid #eee; margin: 15px 0;">

                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <span class="car-price">
                        R$ {{carro.preco_diaria}}<small style="color: #999;">/dia</small>
                    </span>
                    <a href="/cliente/alugar/{{carro.id}}" class="btn-alugar">
                        <i class="fas fa-shopping-cart"></i> Alugar
                    </a>
                </div>
            </div>
        </div>
        % end

        % if not carros:
        <div class="empty-message" style="grid-column: 1/-1;">
            <i class="fas fa-info-circle"></i> Nenhum veículo disponível no momento.
        </div>
        % end

    </div>
</section>