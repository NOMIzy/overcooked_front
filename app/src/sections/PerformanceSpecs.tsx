import { useEffect, useRef } from 'react';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

const SPECS = [
  { value: '±0.05', unit: 'mm', label: '末端精度', desc: '重复定位精度，亚毫米级精准操控', icon: '◉' },
  { value: '1.5', unit: 'kg', label: '最大负载', desc: '轻松端起锅具与食材', icon: '◈' },
  { value: '767', unit: 'mm', label: '工作半径', desc: '覆盖完整厨房操作台面', icon: '◎' },
  { value: '30', unit: 'FPS', label: '视觉帧率', desc: 'Gemini2 深度相机实时感知', icon: '◉' },
];

export default function PerformanceSpecs() {
  const sectionRef = useRef<HTMLElement>(null);
  const cardsRef = useRef<HTMLDivElement[]>([]);

  useEffect(() => {
    const ctx = gsap.context(() => {
      cardsRef.current.forEach((card, i) => {
        if (!card) return;
        gsap.from(card, {
          opacity: 0,
          y: 40,
          duration: 0.8,
          delay: i * 0.15,
          ease: 'power2.out',
          scrollTrigger: {
            trigger: card,
            start: 'top 85%',
          },
        });
      });
    }, sectionRef);

    return () => ctx.revert();
  }, []);

  return (
    <section
      id="performance"
      ref={sectionRef}
      style={{
        backgroundColor: '#1A2E1A',
        padding: '120px 24px',
        position: 'relative',
        zIndex: 5,
      }}
    >
      <div style={{ maxWidth: '1280px', margin: '0 auto' }}>
        <h2
          style={{
            fontFamily: "'Helvetica Neue', 'PingFang SC', 'Microsoft YaHei', sans-serif",
            fontSize: 'clamp(32px, 3vw, 48px)',
            fontWeight: 600,
            lineHeight: 1.2,
            letterSpacing: '-0.5px',
            color: '#FFFFFF',
            textAlign: 'center',
            marginBottom: '16px',
          }}
        >
          AI 主厨性能参数
        </h2>
        <p
          style={{
            fontSize: '16px',
            color: 'rgba(255,255,255,0.6)',
            textAlign: 'center',
            marginBottom: '64px',
          }}
        >
          reBot Arm B601-DM 开源机械臂核心指标
        </p>

        <div
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))',
            gap: '24px',
          }}
        >
          {SPECS.map((spec, i) => (
            <div
              key={spec.label}
              ref={(el) => {
                if (el) cardsRef.current[i] = el;
              }}
              style={{
                background: 'rgba(255,255,255,0.05)',
                border: '1px solid rgba(255,255,255,0.1)',
                borderRadius: '16px',
                padding: '40px 32px',
                textAlign: 'center',
                transition: 'all 0.3s ease',
                cursor: 'default',
              }}
              onMouseEnter={(e) => {
                e.currentTarget.style.background = 'rgba(255,255,255,0.08)';
                e.currentTarget.style.borderColor = '#4CAF50';
                e.currentTarget.style.transform = 'translateY(-4px)';
              }}
              onMouseLeave={(e) => {
                e.currentTarget.style.background = 'rgba(255,255,255,0.05)';
                e.currentTarget.style.borderColor = 'rgba(255,255,255,0.1)';
                e.currentTarget.style.transform = 'translateY(0)';
              }}
            >
              <div
                style={{
                  fontSize: '24px',
                  color: '#4CAF50',
                  marginBottom: '16px',
                }}
              >
                {spec.icon}
              </div>
              <div
                style={{
                  fontSize: 'clamp(40px, 4vw, 64px)',
                  fontWeight: 700,
                  color: '#FF9800',
                  fontFamily: "'Helvetica Neue', 'Courier New', monospace",
                  lineHeight: 1,
                  marginBottom: '8px',
                }}
              >
                {spec.value}
                <span
                  style={{
                    fontSize: '24px',
                    fontWeight: 500,
                    color: 'rgba(255,255,255,0.6)',
                    marginLeft: '4px',
                  }}
                >
                  {spec.unit}
                </span>
              </div>
              <div
                style={{
                  fontSize: '18px',
                  fontWeight: 600,
                  color: '#FFFFFF',
                  marginBottom: '8px',
                }}
              >
                {spec.label}
              </div>
              <div
                style={{
                  fontSize: '14px',
                  color: 'rgba(255,255,255,0.5)',
                  lineHeight: 1.5,
                }}
              >
                {spec.desc}
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
