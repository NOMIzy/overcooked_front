import { useEffect, useRef } from 'react';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

const GALLERY_IMAGES = [
  '/images/cola-wings-v2-01.jpg',
  '/images/cola-wings-v2-02.jpg',
  '/images/cola-wings-v2-03.jpg',
  '/images/egg-rice-v2-01.jpg',
  '/images/egg-rice-v2-02.jpg',
  '/images/cola-wings-v2-04.jpg',
  '/images/egg-rice-v2-03.jpg',
  '/images/cola-wings-v2-05.jpg',
  '/images/egg-rice-v2-04.jpg',
  '/images/egg-rice-v2-05.jpg',
];

export default function HeroSection() {
  const stageRef = useRef<HTMLDivElement>(null);
  const ring1Ref = useRef<HTMLDivElement>(null);
  const ring2Ref = useRef<HTMLDivElement>(null);
  const timelineRefs = useRef<(gsap.core.Tween | gsap.core.Timeline)[]>([]);

  useEffect(() => {
    const stage = stageRef.current;
    const ring1 = ring1Ref.current;
    const ring2 = ring2Ref.current;
    if (!stage || !ring1 || !ring2) return;

    const rings = [ring1, ring2];
    const images = [...GALLERY_IMAGES];

    // Append images to each ring (double for seamless loop)
    rings.forEach((ring) => {
      ring.innerHTML = '';
      [...images, ...images].forEach((src) => {
        const img = document.createElement('img');
        img.src = src;
        img.draggable = false;
        ring.appendChild(img);
      });
    });

    // Set initial transforms
    gsap.set(rings[0], { css: { transformOrigin: '50% 50% -900px', rotationY: 120 } });
    gsap.set(rings[1], { css: { transformOrigin: '50% 50% -820px', rotationY: -60 } });
    rings.forEach((ring) => {
      gsap.set(ring, { css: { rotationX: -5, rotationZ: 2 } });
    });

    // Set individual image transforms
    rings.forEach((ring) => {
      const children = ring.querySelectorAll('img');
      children.forEach((img, index) => {
        const angle = index * 36;
        gsap.set(img, { css: { transformOrigin: '50% 50% 700px', rotationY: angle } });
        img.setAttribute('data-angle', String(angle));
      });
    });

    // Animation function for each ring
    const animateGallery = (ringElement: HTMLDivElement) => {
      const children = ringElement.querySelectorAll('img');
      gsap.set(children, { opacity: 1 });

      const tl = gsap.to(children, {
        rotationY: '-=360',
        duration: 60,
        ease: 'none',
        repeat: -1,
        paused: false,
      });

      timelineRefs.current.push(tl);

      ScrollTrigger.create({
        trigger: stage,
        start: 'top bottom',
        end: 'bottom top',
        onUpdate: (self) => {
          const vel = self.getVelocity();
          const scale = vel / 8000;
          gsap.to(ringElement, {
            rotationZ: vel < 0 ? -scale : scale,
            duration: 0.5,
            ease: 'power2.out',
            overwrite: true,
          });
        },
      });

      ScrollTrigger.create({
        trigger: stage,
        start: 'top 80%',
        onEnter: () => gsap.set(children, { opacity: 1 }),
        onLeaveBack: () => gsap.set(children, { opacity: 0 }),
      });
    };

    rings.forEach((ring) => animateGallery(ring));

    return () => {
      timelineRefs.current.forEach((tl) => tl.kill());
      timelineRefs.current = [];
      ScrollTrigger.getAll().forEach((st) => st.kill());
    };
  }, []);

  return (
    <section id="hero" style={{ position: 'relative', width: '100%', height: '100vh', overflow: 'hidden' }}>
      {/* 3D Gallery Stage */}
      <div id="stage" ref={stageRef}>
        <div className="ring" ref={ring1Ref} />
        <div className="ring" ref={ring2Ref} />
      </div>

      {/* Hero Content Overlay */}
      <div style={{
        position: 'absolute',
        inset: 0,
        zIndex: 10,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        pointerEvents: 'none',
      }}>
        <h1 style={{
          fontFamily: "'Helvetica Neue', 'PingFang SC', 'Microsoft YaHei', sans-serif",
          fontSize: 'clamp(36px, 5vw, 64px)',
          fontWeight: 700,
          lineHeight: 1.1,
          letterSpacing: '-1.5px',
          color: '#FFFFFF',
          textAlign: 'center',
          textShadow: '0 4px 30px rgba(0,0,0,0.6)',
          marginBottom: '20px',
        }}>
          当具身智能，遇见人间烟火
        </h1>
        <p style={{
          fontSize: 'clamp(14px, 1.5vw, 18px)',
          fontWeight: 400,
          lineHeight: 1.6,
          color: 'rgba(255,255,255,0.8)',
          textAlign: 'center',
          maxWidth: '600px',
          marginBottom: '40px',
          textShadow: '0 2px 15px rgba(0,0,0,0.5)',
        }}>
          基于 reBot 机械臂、Gemini2 深度相机与 NVIDIA Jetson 的 AI 主厨系统
        </p>
        <div style={{ display: 'flex', gap: '16px', pointerEvents: 'auto' }}>
          <button
            onClick={() => document.getElementById('architecture')?.scrollIntoView({ behavior: 'smooth' })}
            style={{
              background: '#4CAF50',
              color: '#FFFFFF',
              border: 'none',
              padding: '14px 36px',
              borderRadius: '8px',
              fontSize: '16px',
              fontWeight: 600,
              cursor: 'pointer',
              transition: 'all 0.3s ease',
              fontFamily: "-apple-system, 'PingFang SC', 'Microsoft YaHei', sans-serif",
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
            探索架构
          </button>
          <button
            onClick={() => document.getElementById('about')?.scrollIntoView({ behavior: 'smooth' })}
            style={{
              background: 'transparent',
              color: '#FFFFFF',
              border: '1px solid rgba(255,255,255,0.4)',
              padding: '14px 36px',
              borderRadius: '8px',
              fontSize: '16px',
              fontWeight: 600,
              cursor: 'pointer',
              transition: 'all 0.3s ease',
              fontFamily: "-apple-system, 'PingFang SC', 'Microsoft YaHei', sans-serif",
            }}
            onMouseEnter={(e) => {
              e.currentTarget.style.borderColor = '#4CAF50';
              e.currentTarget.style.color = '#4CAF50';
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.borderColor = 'rgba(255,255,255,0.4)';
              e.currentTarget.style.color = '#FFFFFF';
            }}
          >
            观看演示
          </button>
        </div>
      </div>
    </section>
  );
}
