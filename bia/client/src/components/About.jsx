import React from "react";
import { Link } from "react-router-dom";
import DadosHenrylle from "./DadosHenrylle.jsx";

const About = () => {
  return (
    <div className="about-page">
      <div className="about-content">
        <div className="feature-grid">
          <div className="feature-card highlight">
            <h3>Próximo Evento</h3>
            <h4>AWS & IA</h4>
            <p><strong>28/07 a 03/08/2025</strong><br/>Formação AWS</p>
          </div>
        </div>

        <DadosHenrylle />
      </div>

      <div className="about-footer">
        <Link to="/" className="back-button">
          ← Voltar
        </Link>
      </div>
    </div>
  );
};

export default About;
