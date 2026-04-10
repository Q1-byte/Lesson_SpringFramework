<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- Footer -->
    <footer class="footer py-3 mt-auto text-center">
      <span class="text-muted">&copy; 2026 관리자 페이지. All rights reserved.</span>
    </footer>
  </div>
  </div>

<!-- 다크모드 토글 스크립트 -->
<script>
(function() {
  const themeToggle = document.getElementById('themeToggle');
  const themeIcon = document.getElementById('themeIcon');
  const html = document.documentElement;
  
  // 저장된 테마 또는 시스템 설정 확인
  const savedTheme = localStorage.getItem('theme');
  const systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  const initialTheme = savedTheme || (systemDark ? 'dark' : 'light');
  
  // 초기 테마 적용
  if (initialTheme === 'dark') {
    html.setAttribute('data-theme', 'dark');
    if (themeIcon) themeIcon.textContent = '☀️';
  }
  
  // 토글 버튼 클릭 이벤트
  if (themeToggle) {
    themeToggle.addEventListener('click', () => {
      const isDark = html.getAttribute('data-theme') === 'dark';
      
      if (isDark) {
        html.removeAttribute('data-theme');
        localStorage.setItem('theme', 'light');
        themeIcon.textContent = '🌙';
      } else {
        html.setAttribute('data-theme', 'dark');
        localStorage.setItem('theme', 'dark');
        themeIcon.textContent = '☀️';
      }
    });
  }
})();
</script>

</body>
</html>
    