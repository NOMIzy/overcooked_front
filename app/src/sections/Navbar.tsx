import { useEffect, useRef, useState } from 'react';

export default function Navbar() {
  const [scrolled, setScrolled] = useState(false);
  const navRef = useRef<HTMLElement>(null);

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 50);
    };
    window.addEventListener('scroll', handleScroll, { passive: true });
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const scrollToSection = (id: string) => {
    const el = document.getElementById(id);
    if (el) {
      el.scrollIntoView({ behavior: 'smooth' });
    }
  };

  return (
    <nav
      ref={navRef}
      style={{
        position: 'fixed',
        top: 0,
        left: 0,
        right: 0,
        height: '72px',
        background: 'rgba(10, 10, 10, 0.8)',
        backdropFilter: 'blur(12px)',
        WebkitBackdropFilter: 'blur(12px)',
        borderBottom: scrolled ? '1px solid rgba(255,255,255,0.1)' : '1px solid transparent',
        transition: 'border-color 0.3s ease',
        zIndex: 100,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        padding: '0 24px',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: '12px', cursor: 'pointer' }}
           onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}>
        <svg width="32" height="32" viewBox="0 0 32 32" fill="none">
          <rect x="4" y="12" width="4" height="16" rx="1" fill="#4CAF50"/>
          <rect x="10" y="8" width="4" height="20" rx="1" fill="#4CAF50"/>
          <rect x="16" y="14" width="4" height="14" rx="1" fill="#4CAF50"/>
          <circle cx="22" cy="10" r="5" fill="#FF9800"/>
          <rect x="24" y="4" width="6" height="4" rx="1" fill="#E5E5E5" transform="rotate(15 24 4)"/>
        </svg>
        <span style={{
          color: '#FFFFFF',
          fontSize: '18px',
          fontWeight: 700,
          letterSpacing: '-0.5px',
          fontFamily: "'Helvetica Neue', 'PingFang SC', 'Microsoft YaHei', sans-serif",
        }}>
          COOK WITH ROBOT
        </span>
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: '32px' }}>
        {[
          { label: '项目架构', id: 'architecture' },
          { label: '性能参数', id: 'performance' },
          { label: '开源生态', id: 'opensource' },
          { label: '联系我们', id: 'footer' },
        ].map((item) => (
          <button
            key={item.id}
            onClick={() => scrollToSection(item.id)}
            style={{
              background: 'none',
              border: 'none',
              color: '#E5E5E5',
              fontSize: '14px',
              fontWeight: 500,
              cursor: 'pointer',
              padding: '8px 0',
              position: 'relative',
              transition: 'color 0.3s',
              fontFamily: "-apple-system, 'PingFang SC', 'Microsoft YaHei', sans-serif",
            }}
            onMouseEnter={(e) => (e.currentTarget.style.color = '#4CAF50')}
            onMouseLeave={(e) => (e.currentTarget.style.color = '#E5E5E5')}
          >
            {item.label}
          </button>
        ))}
      </div>
    </nav>
  );
}
