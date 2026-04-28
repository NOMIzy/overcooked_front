import { useEffect, useRef } from 'react';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

const ARCH_LAYERS = [
  {
    title: '感知层',
    subtitle: 'Perception',
    desc: 'Gemini2 深度相机',
    detail: '3D视觉识别 · 物体检测 · 空间定位',
    image: '/images/cola-wings-v2-01.jpg',
    color: '#4CAF50',
  },
  {
    title: '决策层',
    subtitle: 'Decision',
    desc: 'NVIDIA Jetson 边缘推理',
    detail: 'ACT策略 · 轨迹规划 · 动作预测',
    image: '/images/egg-rice-v2-02.jpg',
    color: '#FF9800',
  },
  {
    title: '执行层',
    subtitle: 'Execution',
    desc: 'reBot 6DoF 机械臂',
    detail: '精准控制 · 力反馈 · 夹爪操作',
    image: '/images/cola-wings-v2-05.jpg',
    color: '#4CAF50',
  },
];

export default function TechArchitecture() {
  const wrapperRef = useRef<HTMLElement>(null);
  const titleRef = useRef<HTMLHeadingElement>(null);
  const containerRefs = useRef<HTMLDivElement[]>([]);

  useEffect(() => {
    const wrapper = wrapperRef.current;
    if (!wrapper) return;

    const ctx = gsap.context(() => {
      // Title animation
      if (titleRef.current) {
        gsap.from(titleRef.current, {
          opacity: 0,
          y: 30,
          duration: 0.8,
          ease: 'power2.out',
          scrollTrigger: {
            trigger: titleRef.current,
            start: 'top 85%',
          },
        });
      }

      // Fold animation for each container
      containerRefs.current.forEach((container) => {
        if (!container) return;

        const cols = container.querySelectorAll<HTMLDivElement>('.fold-column');
        if (cols.length < 2) return;

        gsap.set(container, { perspective: 1000 });
        gsap.set(cols[0], { transformOrigin: 'right center', rotationY: -90 });
        gsap.set(cols[1], { transformOrigin: 'left center', rotationY: 90 });

        const tl = gsap.timeline({
          scrollTrigger: {
            trigger: wrapper,
            start: 'top top',
            end: '+=300%',
            pin: true,
            scrub: 1.5,
          },
        });

        tl.fromTo(
          cols[0],
          { rotationY: -90 },
          { rotationY: 0, ease: 'power2.out' },
          '<0.3'
        );

        tl.fromTo(
          cols[1],
          { rotationY: 90 },
          { rotationY: 0, ease: 'power2.out' },
          '<0.3'
        );
      });
    }, wrapper);

    return () => ctx.revert();
  }, []);

  return (
    <section
      id="architecture"
      ref={wrapperRef}
      className="fold-columns-wrapper"
      style={{ flexDirection: 'column', padding: '40px 24px' }}
    >
      <h2
        ref={titleRef}
        style={{
          fontFamily: "'Helvetica Neue', 'PingFang SC', 'Microsoft YaHei', sans-serif",
          fontSize: 'clamp(32px, 3vw, 48px)',
          fontWeight: 600,
          lineHeight: 1.2,
          letterSpacing: '-0.5px',
          color: '#2D2D2D',
          marginBottom: '60px',
          textAlign: 'center',
        }}
      >
        全栈开源架构
      </h2>

      <div
        style={{
          display: 'flex',
          gap: '24px',
          maxWidth: '1280px',
          width: '100%',
          justifyContent: 'center',
          flexWrap: 'wrap',
        }}
      >
        {ARCH_LAYERS.map((layer, i) => (
          <div
            key={layer.title}
            ref={(el) => {
              if (el) containerRefs.current[i] = el;
            }}
            className="fold-column-container"
            style={{
              width: '320px',
              borderRadius: '16px',
              overflow: 'hidden',
              position: 'relative',
            }}
          >
            <div className="fold-column" style={{ width: '50%', height: '100%' }}>
              <div
                style={{
                  width: '200%',
                  height: '100%',
                  position: 'relative',
                }}
              >
                <img
                  src={layer.image}
                  alt={layer.title}
                  style={{
                    width: '100%',
                    height: '100%',
                    objectFit: 'cover',
                    filter: 'brightness(0.4)',
                  }}
                />
              </div>
            </div>
            <div className="fold-column" style={{ width: '50%', height: '100%' }}>
              <div
                style={{
                  width: '200%',
                  height: '100%',
                  position: 'relative',
                  left: '-100%',
                }}
              >
                <img
                  src={layer.image}
                  alt={layer.title}
                  style={{
                    width: '100%',
                    height: '100%',
                    objectFit: 'cover',
                    filter: 'brightness(0.4)',
                  }}
                />
              </div>
            </div>

            {/* Overlay Content */}
            <div
              style={{
                position: 'absolute',
                inset: 0,
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                zIndex: 10,
                pointerEvents: 'none',
              }}
            >
              <div
                style={{
                  background: layer.color,
                  color: '#FFFFFF',
                  padding: '4px 16px',
                  borderRadius: '20px',
                  fontSize: '12px',
                  fontWeight: 600,
                  marginBottom: '12px',
                  textTransform: 'uppercase',
                  letterSpacing: '1px',
                }}
              >
                {layer.subtitle}
              </div>
              <h3
                style={{
                  fontSize: '28px',
                  fontWeight: 700,
                  color: '#FFFFFF',
                  marginBottom: '8px',
                  textShadow: '0 2px 10px rgba(0,0,0,0.5)',
                }}
              >
                {layer.title}
              </h3>
              <p
                style={{
                  fontSize: '16px',
                  color: '#FFFFFF',
                  fontWeight: 500,
                  marginBottom: '8px',
                  textShadow: '0 2px 8px rgba(0,0,0,0.5)',
                }}
              >
                {layer.desc}
              </p>
              <p
                style={{
                  fontSize: '13px',
                  color: 'rgba(255,255,255,0.8)',
                  textShadow: '0 1px 5px rgba(0,0,0,0.5)',
                }}
              >
                {layer.detail}
              </p>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
