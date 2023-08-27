const express = require("express");
const app = express();
const mysql = require("mysql2");
const cors = require("cors");

const db = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '62442',
    database: 'hospital',
});

app.use(cors());
app.use(express.json());

app.get("/search1/:medico", (req, res) => {
    let medico = req.originalUrl;
    medico = medico.replace("/search1/", "")

    const decode = decodeURIComponent(medico.replace("%20", " "));

    let mysql =
    `SELECT nome, RG, especialidade, crm, salario 
    FROM (medico natural join horista) natural join empregado 
    where nome like "%${decode}%"
    UNION 
    SELECT nome, RG, especialidade, crm, salario 
    FROM (medico natural join plantonista) natural join empregado
    where nome like "%${decode}%";`;
    
    db.query(mysql, (err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    });
});

app.get("/search1-1/:medico", (req, res) => {
    let medico = req.originalUrl;
    medico = medico.replace("/search1-1/", "")

    const decode = decodeURIComponent(medico.replace("%20", " "));

    let mysql =
    `SELECT CodigoCti, DiaCTI as Dia, EntradaCTI as Entrada, SaidaCTI as Saida
    FROM medicos natural join atendimentoCti
    WHERE nome like "%${decode}%";`;
    
    db.query(mysql, (err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    });
});

app.get("/search1-2/:medico", (req, res) => {
    let medico = req.originalUrl;
    medico = medico.replace("/search1-2/", "")

    const decode = decodeURIComponent(medico.replace("%20", " "));
    
    let mysql =
    `SELECT NumeroConsultorio, CodigoProntoSocorro, DiaConsultorio as Dia, EntradaConsultorio as Entrada, SaidaConsultorio as Saida
    FROM medicos natural join atendimentoConsultorio
    WHERE nome like "%${decode}%";`;
    
    db.query(mysql, (err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    });
});

app.get("/search2/:locais", (req, res) => {
    let locais = req.originalUrl;
    locais = locais.replace("/search2/", "")

    const partes = locais.split("-");

    const cti = parseInt(partes[0]);
    const prontosocorro = parseInt(partes[1]);

    let mysql =
    `SELECT especialidade, crm, RG, nome 
    from ((medico natural join atendimentoCti) natural join horista) natural join empregado
    where codigocti = ${cti}
    UNION
    select especialidade, crm, RG, nome 
    from ((medico natural join atendimentoConsultorio) natural join horista) natural join empregado
    where codigoprontosocorro = ${prontosocorro}
    union
    SELECT especialidade, crm, RG, nome 
    from ((medico natural join atendimentoCti) natural join plantonista) natural join empregado
    where codigocti = ${cti}
    UNION
    select especialidade, crm, RG, nome 
    from ((medico natural join atendimentoConsultorio) natural join plantonista) natural join empregado
    where codigoprontosocorro = ${prontosocorro};`;

    
    db.query(mysql, (err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    });

});

app.get("/search3/:farmacia", (req, res) => {
    let farmacia = req.originalUrl;
    farmacia = farmacia.replace("/search3/", "")

    const decode = decodeURIComponent(farmacia.replace("%20", " "));

    let mysql =
    `SELECT codigo, nome, validade, t.nomefarmacia 
    FROM (medicamento as m join medicamentofisico as ms on m.codigo=ms.codigomedicamento) 
    join tem as t on t.codigomedicamento=m.codigo 
    WHERE t.nomefarmacia='` + decode + `'`;
    
    db.query(mysql, (err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    });

});

app.get("/update/:update", (req, res) => {
    let update = req.originalUrl;
    update = update.replace("/update/", "")

    const decode = decodeURIComponent(update.replace("%20", " "));

    const parts = decode.split("-");

    const nome = parts[0];
    const salario = parseInt(parts[1]);

    let mysql =
    `update medico 
    set Salario = ${salario} 
    where CodigoMed = ( 
        select CodigoMed 
        from medicos 
        where nome like "%${nome}%" 
        union 
        select CodigoMed 
        from medicos 
        where nome like "%${nome}%" 
    );`;

    db.query(mysql, (err, result) => {
        if (err) {
            res.send(err);
        }
        else {
            res.send(result);
        }
    });

});

app.listen(3001, () => {
    console.log("rodando servidor");
});