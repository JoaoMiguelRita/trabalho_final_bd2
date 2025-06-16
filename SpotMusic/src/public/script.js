document.addEventListener('DOMContentLoaded', () => {
    const cadastroForm = document.getElementById('cadastroForm');
    const messageDiv = document.getElementById('message');

    cadastroForm.addEventListener('submit', async (event) => {
        event.preventDefault(); // Impede o recarregamento da página

        messageDiv.className = ''; // Limpa classes de mensagem anteriores
        messageDiv.textContent = ''; // Limpa texto de mensagem anterior

        const nome = document.getElementById('nome').value;
        const email = document.getElementById('email').value;
        const senha = document.getElementById('senha').value;
        let dt_nascimento = document.getElementById('dt_nascimento').value; // Formato YYYY-MM-DD do input type="date"
        const tipo_conta = document.getElementById('tipo_conta').value;

        // Formatação da data para o formato DD/MM/YYYY HH:mm:ss esperado pela sua API
        if (dt_nascimento) {
            const [year, month, day] = dt_nascimento.split('-');
            dt_nascimento = `${month}/${day}/${year} 00:00:00`;
        }

        const userData = {
            nome,
            email,
            senha,
            dt_nascimento,
            tipo_conta
        };

        try {
            // A URL da API, com o prefixo '/api' que definimos no server.js
            const response = await fetch('/api/usuarios', { // Mude para '/api/usuarios' se usou o prefixo
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(userData),
            });

            const data = await response.json(); // Tenta parsear a resposta como JSON

            if (response.ok) { // Verifica se o status da resposta é 2xx (ex: 200 OK, 201 Created)
                messageDiv.className = 'success';
                messageDiv.textContent = data.message || 'Usuário cadastrado com sucesso!';
                cadastroForm.reset(); // Limpa o formulário
            } else {
                // Se a resposta não foi OK, mostra a mensagem de erro da API
                messageDiv.className = 'error';
                messageDiv.textContent = data.message || 'Erro ao cadastrar usuário.';
            }
        } catch (error) {
            // Erros de rede ou outros problemas antes de receber uma resposta da API
            messageDiv.className = 'error';
            messageDiv.textContent = 'Erro ao conectar com o servidor. Tente novamente mais tarde.';
            console.error('Erro na requisição Fetch:', error);
        }
    });
});