import React, { useState } from "react";
import "./Update.css";  

function Update({onClick, close}) {
    const [nome, setNome] = useState('');
    const [salario, setSalario] = useState('');
  
    const handleNomeChange = (event) => {
      setNome(event.target.value);
    };
  
    const handleSalarioChange = (event) => {
      setSalario(event.target.value);
    };

    function handleButtonConfirm() {
        onClick(nome, salario);
    }

    function handleButtonCancel() {
        close();
    }
  
    return (
      <div className="container-update">
        <div className="title">
            Atualizar BD
        </div>
        <div className="descricao">
            Atualiza o salário de um médico
        </div>
        <label className="input">
          Nome:
          <input type="text" value={nome} onChange={handleNomeChange} />
        </label>
        <br />
        <label className="input">
          Salário:
          <input type="number" value={salario} onChange={handleSalarioChange} />
        </label>
        <div className="button-update-ctn" >
            <button className="button-update" onClick={handleButtonConfirm}>Confirmar</button>
            <button className="button-update" onClick={handleButtonCancel}>Cancelar</button>

        </div>
      </div>
    );
}

export default Update;