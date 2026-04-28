import { useEffect, useRef } from 'react';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

const TECH_WORDS = ['LeRobot', 'ROS2', 'PyTorch', 'CUDA', 'Open Source', 'Embodied AI', 'Gemini2', 'Jetson'];
const TEXT_SOURCE = TECH_WORDS.join(' · ') + ' · ';

const TECH_STACK = [
  { name: 'LeRobot', desc: 'HuggingFace 机器人学习框架', role: '策略学习' },
  { name: 'ROS2', desc: '机器人操作系统', role: '通信中间件' },
  { name: 'PyTorch', desc: '深度学习框架', role: '模型训练' },
  { name: 'CUDA', desc: 'GPU 并行计算', role: '推理加速' },
  { name: 'Gemini2', desc: '奥比中光深度相机', role: '视觉感知' },
  { name: 'Jetson', desc: 'NVIDIA 边缘计算', role: '端侧推理' },
];

export default function OpenSourceSection() {
  const sectionRef = useRef<HTMLElement>(null);
  const trackRef = useRef<HTMLDivElement>(null);
  const stackRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const track = trackRef.current;
    if (!track) return;

    // Build zigzag items
    track.innerHTML = '';
    const text = TEXT_SOURCE;
    const length = text.length;

    for (let i = 0; i < length; i++) {
      const div = document.createElement('div');
      div.textContent = text[i];
      div.className = 'zigzag-item';
      div.style.cssText = `
        --index: ${i};
        --base-angle: calc(360deg / ${length} * ${i});
        --angle-offset: 0deg;
        --zigzag-depth: calc(sin(var(--base-angle) + var(--angle-offset)) * 200px);
        --zigzag-angle: calc(cos(var(--base-angle) + var(--angle-offset)) * 15deg);
      `;
      track.appendChild(div);
    }

    const ctx = gsap.context(() => {
      if (stackRef.current) {
        gsap.from(stackRef.current.children, {
          opacity: 0,
          y: 30,
          duration: 0.6,
          stagger: 0.1,
          ease: 'power2.out',
          scrollTrigger: {
            trigger: stackRef.current,
            start: 'top 80%',
          },
        });
      }
    }, sectionRef);

    return () => ctx.revert();
  }, []);

  return (
    <section
      id="opensource"
      ref={sectionRef}
      style={{
        minHeight: '100vh',
        background: '#0A0A0A',
        position: 'relative',
        overflow: 'hidden',
        zIndex: 5,
        padding: '120px 24px',
      }}
    >
      {/* Section Title */}
      <div style={{ textAlign: 'center', marginBottom: '60px', position: 'relative', zIndex: 20 }}>
        <h2
          style={{
            fontFamily: "'Helvetica Neue', 'PingFang SC', 'Microsoft YaHei', sans-serif",
            fontSize: 'clamp(32px, 3vw, 48px)',
            fontWeight: 600,
            lineHeight: 1.2,
            letterSpacing: '-0.5px',
            color: '#FFFFFF',
            marginBottom: '16px',
          }}
        >
          我们的开源技术栈
        </h2>
        <p style={{ fontSize: '16px', color: 'rgba(255,255,255,0.5)', maxWidth: '500px', margin: '0 auto' }}>
          基于开源生态构建，所有代码与模型将向社区开放
        </p>
      </div>

      {/* Tech Stack Cards */}
      <div
        ref={stackRef}
        style={{
          maxWidth: '1280px',
          margin: '0 auto',
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
          gap: '20px',
          position: 'relative',
          zIndex: 20,
        }}
      >
        {TECH_STACK.map((tech) => (
          <div
            key={tech.name}
            style={{
              background: 'rgba(255,255,255,0.04)',
              border: '1px solid rgba(255,255,255,0.08)',
              borderRadius: '16px',
              padding: '32px',
              transition: 'all 0.3s ease',
              cursor: 'default',
            }}
            onMouseEnter={(e) => {
              e.currentTarget.style.background = 'rgba(76, 175, 80, 0.08)';
              e.currentTarget.style.borderColor = '#4CAF50';
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.background = 'rgba(255,255,255,0.04)';
              e.currentTarget.style.borderColor = 'rgba(255,255,255,0.08)';
            }}
          >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
              <h3 style={{ fontSize: '24px', fontWeight: 700, color: '#4CAF50', fontFamily: "'Helvetica Neue', monospace" }}>
                {tech.name}
              </h3>
              <span
                style={{
                  fontSize: '12px',
                  fontWeight: 600,
                  color: '#FF9800',
                  background: 'rgba(255, 152, 0, 0.1)',
                  padding: '4px 12px',
                  borderRadius: '20px',
                }}
              >
                {tech.role}
              </span>
            </div>
            <p style={{ fontSize: '15px', color: 'rgba(255,255,255,0.6)', lineHeight: 1.6 }}>
              {tech.desc}
            </p>
          </div>
        ))}
      </div>

      {/* GitHub CTA */}
      <div style={{ textAlign: 'center', marginTop: '60px', position: 'relative', zIndex: 20 }}>
        <a
          href="https://github.com/Seeed-Projects/rebot"
          target="_blank"
          rel="noopener noreferrer"
          style={{
            display: 'inline-flex',
            alignItems: 'center',
            gap: '8px',
            background: '#4CAF50',
            color: '#FFFFFF',
            padding: '16px 40px',
            borderRadius: '12px',
            fontSize: '16px',
            fontWeight: 600,
            textDecoration: 'none',
            transition: 'all 0.3s ease',
          }}
          onMouseEnter={(e) => {
            e.currentTarget.style.filter = 'brightness(1.1)';
            e.currentTarget.style.transform = 'scale(1.02)';
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.filter = 'brightness(1)';
            e.currentTarget.style.transform = 'scale(1)';
          }}
        >
          <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
          </svg>
          查看项目代码
        </a>
      </div>
    </section>
  );
}
