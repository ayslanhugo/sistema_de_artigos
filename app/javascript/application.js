// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
// --- LÓGICA DO MODO NOTURNO (DARK MODE) ---

document.addEventListener('turbo:load', () => {
  const themeToggler = document.getElementById('theme-toggler');
  const htmlElement = document.documentElement; // A tag <html>

  // Função para aplicar o tema e atualizar o ícone
  const applyTheme = (theme) => {
    htmlElement.setAttribute('data-bs-theme', theme);
    if (themeToggler) {
      const icon = themeToggler.querySelector('i');
      icon.className = theme === 'dark' ? 'bi bi-sun-fill' : 'bi bi-moon-stars-fill';
    }
  };

  // 1. Ao carregar a página, verifique o tema salvo no navegador do usuário
  const savedTheme = localStorage.getItem('theme') || 'light'; // O padrão é 'light'
  applyTheme(savedTheme);

  // 2. Adicione o evento de clique ao botão
  if (themeToggler) {
    themeToggler.addEventListener('click', (event) => {
      event.preventDefault(); // Impede que o link '#' cause um pulo na página

      // Verifique qual é o tema atual e troque para o outro
      const currentTheme = htmlElement.getAttribute('data-bs-theme');
      const newTheme = currentTheme === 'dark' ? 'light' : 'dark';

      // Aplica o novo tema e o salva no navegador para futuras visitas
      applyTheme(newTheme);
      localStorage.setItem('theme', newTheme);
    });
  }
});