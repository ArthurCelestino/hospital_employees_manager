import React, { useState } from "react";
import Axios from 'axios';
import { Dropdown, Option } from "./Dropdown";
import Update from "./Update";
import Modal from "./Modal";
import "./App.css";

function App() {
  const [medico, setMedico] = useState('');
  const [atendeCti, setAtendeCti] = useState('');
  const [atendeConsultorio, setAtendeConsultorio] = useState('');
  const [farmacia, setFarmacia] = useState('');
  const [cti, setCti] = useState('');
  const [ps, setPs] = useState('');

  const [result1, setResult1] = useState();
  const [result2, setResult2] = useState();
  const [result3, setResult3] = useState();

  const [buttonClicked, setButtonClicked] = useState(false);

  const handleFarmaciaChange = (event) => {
    setFarmacia(event.target.value);
  };

  function query1(){
    if(medico === ""){
      alert("Informe o nome de algum médico!");
    }
    else{
      Axios.get(`http://localhost:3001/search1/${medico}`).then((response) => {
        setResult1(response.data);
      })
      query1_1();
      query1_2();
    }
  }

  function query1_1() {
    Axios.get(`http://localhost:3001/search1-1/${medico}`).then((response) => {
      setAtendeCti(response.data);
    })
  }

  function query1_2() {
    Axios.get(`http://localhost:3001/search1-2/${medico}`).then((response) => {
      setAtendeConsultorio(response.data);
    })
  }

  function query2(){
    if(cti === ""){
      alert("Informe algum CTI!");
    }
    else if(ps === ""){
      alert("Informe algum Pronto-Socorro!");
    }
    else{
      Axios.get(`http://localhost:3001/search2/${cti}-${ps}`).then((response) => {
        setResult2(response.data);
      })
    }
  }

  function query3(e){
    e.preventDefault();
    if(farmacia === ""){
      alert("Escolha uma opção!");
    }
    else if(farmacia === "Clique para ver as opções"){
      alert("Escolha uma opção válida!");
    }
    else {
      Axios.get(`http://localhost:3001/search3/${farmacia}`).then((response) => {
        setResult3(response.data);
      })
    }
  }

  function update(nome, salario){
    if(nome !== "" && salario !== ""){
      setButtonClicked(false);
      Axios.get(`http://localhost:3001/update/${nome}-${salario}`).then((response) => {
        alert("BD Atualizado com Sucesso!");
      })
    }
  }

  function close(){
    setButtonClicked(false);
  }

  return (
    <div>
      <h1 className="App-header">TP2 - Banco de Dados</h1>
      <div className="button-container">
        <button className="button" onClick={() => {setButtonClicked(true)}}>Atualizar BD</button>
      </div>
      <div className="container">
        <div className="query">
          <div>
            Informe o nome do Médico para ver seus dados.
          </div>
          <div>
            <label className="input">
              Médico:
              <input type="text" value={medico} onChange={(e) => {setMedico(e.target.value);}} />
            </label>
          </div>
          <button onClick={query1} className="button-confirm">Confirmar</button>
          <p>Resultado: </p>
          {(result1 || atendeCti || atendeConsultorio) && 
            <div className="res">
              {result1 && result1.map((res) => {
                return (
                  <div key={res.RG}>
                    <div>Nome: {res.nome}</div>
                    <div>CRM: {res.crm}</div>
                    <div>RG: {res.RG}</div>
                    <div>Especialidade: {res.especialidade}</div>
                    <div>Salário: {res.salario}</div>
                  </div>
                );
              })}
              {atendeCti && atendeCti.map((atende) => {
                return (
                  <div className="line">
                    <div>CTI: {atende.CodigoCti}</div>
                    <div>Dia: {atende.Dia}</div>
                    <div>Hora de Entrada: {atende.Entrada}</div>
                    <div>Hora de Saída: {atende.Saida}</div>
                  </div>
                )
              })}
              {atendeConsultorio && atendeConsultorio.map((atende) => {
                return (
                  <div className="line">
                    <div>Consultorio: {atende.NumeroConsultorio}</div>
                    <div>Pronto-Socorro: {atende.CodigoProntoSocorro}</div>
                    <div>Dia: {atende.Dia}</div>
                    <div>Hora de Entrada: {atende.Entrada}</div>
                    <div>Hora de Saída: {atende.Saida}</div>
                  </div>
                )
              })}
            </div>
          }
        </div>
        <div className="query">
          <div>
            Informe o CTI e o Pronto-Socorro, para visualizar os Médicos que trabalham em algum deles.
          </div>
          <div>
            <label className="input">
              CTI:
              <input type="number" value={cti} onChange={(e) => {setCti(e.target.value);}} />
            </label>
            <br />
            <label className="input">
              Pronto-Socorro:
              <input type="number" value={ps} onChange={(e) => {setPs(e.target.value);}} />
            </label>
          </div>
          <button onClick={query2} className="button-confirm">Confirmar</button>
          <p>Resultado: </p>
          {result2 && result2.map((res) => {
            return (
              <div className="res" key={res.RG}>
                <div>Nome: {res.nome}</div>
                <div>CRM: {res.crm}</div>
                <div>RG: {res.RG}</div>
                <div>Especialidade: {res.especialidade}</div>
              </div>
            );
          })}
        </div>
        <div className="query">
          <Dropdown
            formLabel="Selecione uma farmácia para ver sua lista de medicamentos físicos."
            buttonText="Confirmar"
            onChange={handleFarmaciaChange}
            onSubmit={query3}
          >
            <Option default value="Clique para ver as opções" />
            <Option value="Farmacia 1" />
            <Option value="Farmacia 2" />
          </Dropdown>
          <p>Result: </p>
          {result3 && result3.map((res) => {
            return (
              <div className="res" key={res.validade}>
                <div>Medicamento: {res.nome}</div>
                <div>Validade: {res.validade}</div>
                <div>Código: {res.codigo}</div>
                <div>Farmacia: {res.nomefarmacia}</div>
              </div>
            );
          })}
        </div>
      </div>

      <Modal isOpen={buttonClicked}>
        <Update onClick={update} close={close}/>
      </Modal>  
    </div>
  );
}

export default App;
