const app = require("./app");

/*app.listen(3333, () => console.log("Server is on"));*/


const PORT = process.env.PORT || 3333; // Define a porta

app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
    console.log(`Acesse sua aplicação em http://localhost:${PORT}`);
});