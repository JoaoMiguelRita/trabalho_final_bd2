let usuarioEditandoId = null;
const botaoSubmit = document.querySelector('#cadastroForm button[type="submit"]');

// Função para carregar e exibir os usuários na tabela
async function carregarUsuarios() {
    try {
        const response = await fetch('/api/usuarios');
        const usuarios = await response.json();

        const tabelaBody = document.querySelector('#usuarios-table tbody');
        tabelaBody.innerHTML = '';

        usuarios.forEach(usuario => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${usuario.nome}</td>
                <td>${usuario.email}</td>
                <td>${new Date(usuario.dt_nascimento).toLocaleDateString('pt-BR')}</td>
                <td>${usuario.tipo_conta}</td>
                <td>
                    <button onclick="editarUsuario(${usuario.id_usuario})">Editar</button>
                    <button onclick="deletarUsuario(${usuario.id_usuario})">Excluir</button>
                </td>
            `;
            tabelaBody.appendChild(row);
        });
    } catch (error) {
        console.error('Erro ao carregar usuários:', error);
    }
}

// Função para preparar a edição do usuário
async function editarUsuario(id) {
    try {
        botaoSubmit.textContent = 'Salvar';
        const response = await fetch('/api/usuarios');
        const usuarios = await response.json();
        const usuario = usuarios.find(u => u.id_usuario === id);

        if (usuario) {
            document.getElementById('nome').value = usuario.nome;
            document.getElementById('email').value = usuario.email;
            document.getElementById('senha').value = usuario.senha;
            document.getElementById('dt_nascimento').value = new Date(usuario.dt_nascimento).toISOString().split('T')[0];
            document.getElementById('tipo_conta').value = usuario.tipo_conta;

            usuarioEditandoId = id;
            document.getElementById('cancelarEdicao').style.display = 'inline'; // Exibe botão cancelar
        }

        window.scrollTo({ top: 0, behavior: 'smooth' });
    } catch (error) {
        console.error("Erro ao buscar usuário para edição:", error);
    }
}

// Função para deletar um usuário
async function deletarUsuario(id) {
    if (!confirm("Tem certeza que deseja excluir este usuário?")) return;

    try {
        const response = await fetch(`/api/usuarios/${id}`, {
            method: 'DELETE',
        });

        if (response.ok) {
            alert("Usuário excluído com sucesso.");
            carregarUsuarios();
        } else {
            const data = await response.json();
            alert(data.message || "Erro ao excluir usuário.");
        }
    } catch (error) {
        console.error("Erro ao excluir usuário:", error);
        alert("Erro ao conectar com o servidor.");
    }
}

// Ação principal após o DOM carregar
document.addEventListener('DOMContentLoaded', () => {
    const cadastroForm = document.getElementById('cadastroForm');
    const messageDiv = document.getElementById('message');
    const cancelarBtn = document.getElementById('cancelarEdicao');

    cadastroForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        messageDiv.className = '';
        messageDiv.textContent = '';

        const nome = document.getElementById('nome').value;
        const email = document.getElementById('email').value;
        const senha = document.getElementById('senha').value;
        let dt_nascimento = document.getElementById('dt_nascimento').value;
        const tipo_conta = document.getElementById('tipo_conta').value;

        if (dt_nascimento) {
            const [year, month, day] = dt_nascimento.split('-');
            dt_nascimento = `${month}/${day}/${year} 00:00:00`;
        }

        const userData = { nome, email, senha, dt_nascimento, tipo_conta };

        const url = usuarioEditandoId
            ? `/api/usuarios/${usuarioEditandoId}`
            : '/api/usuarios';

        const metodo = usuarioEditandoId ? 'PUT' : 'POST';

        try {
            const response = await fetch(url, {
                method: metodo,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(userData),
            });

            const data = await response.json();

            if (response.ok) {
                messageDiv.className = 'success';
                messageDiv.textContent = usuarioEditandoId
                    ? 'Usuário atualizado com sucesso!'
                    : 'Usuário cadastrado com sucesso!';
                    botaoSubmit.textContent = 'Cadastrar';

                cadastroForm.reset();
                usuarioEditandoId = null;
                cancelarBtn.style.display = 'none';
                carregarUsuarios();
            } else {
                messageDiv.className = 'error';
                messageDiv.textContent = data.message || 'Erro ao processar dados.';
            }
        } catch (error) {
            messageDiv.className = 'error';
            messageDiv.textContent = 'Erro ao conectar com o servidor.';
            console.error('Erro na requisição:', error);
        }
    });

    // Ação do botão "Cancelar Edição"
    cancelarBtn.addEventListener('click', () => {
        botaoSubmit.textContent = 'Cadastrar';
        cadastroForm.reset();
        usuarioEditandoId = null;
        messageDiv.textContent = '';
        cancelarBtn.style.display = 'none';
    });
    carregarUsuarios();
});
