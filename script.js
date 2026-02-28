/* ============================================
   VKS WEDDING DECORATIONS — LUXURY JS
   Animations, Interactions & Scroll Effects
   ============================================ */

document.addEventListener('DOMContentLoaded', () => {

  // ---------- PRELOADER ----------
  const preloader = document.getElementById('preloader');
  window.addEventListener('load', () => {
    setTimeout(() => {
      preloader.classList.add('hidden');
    }, 1500);
  });

  // Fallback — hide preloader after 4s regardless
  setTimeout(() => {
    preloader.classList.add('hidden');
  }, 4000);

  // ---------- HERO PARTICLES ----------
  const particlesContainer = document.getElementById('heroParticles');
  if (particlesContainer) {
    for (let i = 0; i < 30; i++) {
      const particle = document.createElement('div');
      particle.classList.add('particle');
      particle.style.left = Math.random() * 100 + '%';
      particle.style.width = (Math.random() * 3 + 1) + 'px';
      particle.style.height = particle.style.width;
      particle.style.animationDelay = Math.random() * 8 + 's';
      particle.style.animationDuration = (Math.random() * 6 + 5) + 's';
      particle.style.opacity = Math.random() * 0.5 + 0.2;
      particlesContainer.appendChild(particle);
    }
  }

  // ---------- NAVBAR SCROLL ----------
  const navbar = document.getElementById('navbar');
  const backToTop = document.getElementById('backToTop');

  const handleScroll = () => {
    const scrollY = window.scrollY;

    // Navbar bg
    if (scrollY > 80) {
      navbar.classList.add('scrolled');
    } else {
      navbar.classList.remove('scrolled');
    }

    // Back to top button
    if (scrollY > 600) {
      backToTop.classList.add('show');
    } else {
      backToTop.classList.remove('show');
    }
  };

  window.addEventListener('scroll', handleScroll, { passive: true });

  // Back to top click
  if (backToTop) {
    backToTop.addEventListener('click', () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // ---------- MOBILE MENU ----------
  const menuToggle = document.getElementById('menuToggle');
  const navLinks = document.getElementById('navLinks');

  if (menuToggle && navLinks) {
    menuToggle.addEventListener('click', () => {
      menuToggle.classList.toggle('active');
      navLinks.classList.toggle('active');
      document.body.style.overflow = navLinks.classList.contains('active') ? 'hidden' : '';
    });

    // Close menu on link click
    navLinks.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        menuToggle.classList.remove('active');
        navLinks.classList.remove('active');
        document.body.style.overflow = '';
      });
    });
  }

  // ---------- SMOOTH SCROLL FOR ANCHOR LINKS ----------
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const targetId = this.getAttribute('href');
      if (targetId === '#') return;

      e.preventDefault();
      const targetEl = document.querySelector(targetId);
      if (targetEl) {
        const navHeight = navbar.offsetHeight;
        const targetPosition = targetEl.getBoundingClientRect().top + window.scrollY - navHeight;
        window.scrollTo({ top: targetPosition, behavior: 'smooth' });
      }
    });
  });

  // ---------- SCROLL REVEAL ANIMATIONS ----------
  const revealElements = document.querySelectorAll('.reveal, .reveal-left, .reveal-right, .reveal-scale');

  const revealObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('active');
        revealObserver.unobserve(entry.target);
      }
    });
  }, {
    threshold: 0.12,
    rootMargin: '0px 0px -60px 0px'
  });

  revealElements.forEach(el => {
    revealObserver.observe(el);
  });

  // ---------- COUNTER ANIMATION ----------
  const counters = document.querySelectorAll('.stat-number[data-count]');

  const counterObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const el = entry.target;
        const target = parseInt(el.getAttribute('data-count'));
        animateCounter(el, target);
        counterObserver.unobserve(el);
      }
    });
  }, { threshold: 0.5 });

  counters.forEach(counter => counterObserver.observe(counter));

  function animateCounter(el, target) {
    let current = 0;
    const increment = target / 60;
    const duration = 2000;
    const stepTime = duration / 60;

    const timer = setInterval(() => {
      current += increment;
      if (current >= target) {
        current = target;
        clearInterval(timer);
      }
      el.textContent = Math.floor(current) + '+';
    }, stepTime);
  }

  // ---------- GALLERY FILTER ----------
  const filterBtns = document.querySelectorAll('.gallery-filter-btn');
  const galleryItems = document.querySelectorAll('.gallery-item');

  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      // Update active button
      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      const filter = btn.getAttribute('data-filter');

      galleryItems.forEach((item, index) => {
        const category = item.getAttribute('data-category');

        if (filter === 'all' || category === filter) {
          item.style.transition = `opacity 0.4s ease ${index * 0.05}s, transform 0.4s ease ${index * 0.05}s`;
          item.style.opacity = '1';
          item.style.transform = 'scale(1)';
          item.style.display = '';
        } else {
          item.style.opacity = '0';
          item.style.transform = 'scale(0.9)';
          setTimeout(() => {
            item.style.display = 'none';
          }, 400);
        }
      });
    });
  });

  // ---------- LIGHTBOX ----------
  const lightbox = document.getElementById('lightbox');
  const lightboxImage = document.getElementById('lightboxImage');
  const lightboxClose = document.getElementById('lightboxClose');

  galleryItems.forEach(item => {
    item.addEventListener('click', () => {
      const imgSrc = item.querySelector('img').src;
      lightboxImage.src = imgSrc;
      lightbox.classList.add('active');
      document.body.style.overflow = 'hidden';
    });
  });

  if (lightboxClose) {
    lightboxClose.addEventListener('click', closeLightbox);
  }

  if (lightbox) {
    lightbox.addEventListener('click', (e) => {
      if (e.target === lightbox) {
        closeLightbox();
      }
    });
  }

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && lightbox.classList.contains('active')) {
      closeLightbox();
    }
  });

  function closeLightbox() {
    lightbox.classList.remove('active');
    document.body.style.overflow = '';
    setTimeout(() => {
      lightboxImage.src = '';
    }, 400);
  }

  // ---------- FORM SUBMISSION ----------
  const leadForm = document.getElementById('leadForm');
  const submitBtn = document.getElementById('submitBtn');

  if (leadForm) {
    leadForm.addEventListener('submit', (e) => {
      e.preventDefault();

      const formData = new FormData(leadForm);
      const name = formData.get('name');
      const date = formData.get('wedding_date');
      const phone = formData.get('phone');
      const venue = formData.get('venue') || 'Not decided';
      const budget = formData.get('budget');

      // Build WhatsApp message
      const message = `Hello VKS Wedding Decorations! 🌸\n\n` +
        `I'd like to check availability for my wedding:\n\n` +
        `👤 Name: ${name}\n` +
        `📅 Date: ${date}\n` +
        `📍 Venue: ${venue}\n` +
        `💰 Budget: ${budget}\n` +
        `📱 Phone: ${phone}\n\n` +
        `Please confirm if this date is available. Thank you!`;

      const whatsappUrl = `https://wa.me/919994012325?text=${encodeURIComponent(message)}`;

      // Button feedback
      submitBtn.textContent = '✓  Redirecting to WhatsApp...';
      submitBtn.style.pointerEvents = 'none';

      setTimeout(() => {
        window.open(whatsappUrl, '_blank');
        submitBtn.textContent = '✦   Check Date Availability';
        submitBtn.style.pointerEvents = '';
        leadForm.reset();
      }, 800);
    });
  }

  // ---------- FORM INPUT ANIMATIONS ----------
  document.querySelectorAll('.form-group input, .form-group select, .form-group textarea').forEach(input => {
    input.addEventListener('focus', () => {
      input.parentElement.style.transform = 'translateY(-2px)';
      input.parentElement.style.transition = 'transform 0.3s ease';
    });

    input.addEventListener('blur', () => {
      input.parentElement.style.transform = 'translateY(0)';
    });
  });

  // ---------- PARALLAX ON HERO (subtle) ----------
  const hero = document.querySelector('.hero');
  const heroBg = document.querySelector('.hero-bg img');

  if (hero && heroBg) {
    window.addEventListener('scroll', () => {
      const scrollY = window.scrollY;
      if (scrollY < window.innerHeight) {
        heroBg.style.transform = `scale(${1.05 + scrollY * 0.0002}) translateY(${scrollY * 0.15}px)`;
      }
    }, { passive: true });
  }

  // ---------- CURSOR GLOW EFFECT (Desktop) ----------
  if (window.innerWidth > 768) {
    const glow = document.createElement('div');
    glow.style.cssText = `
      position: fixed;
      width: 300px;
      height: 300px;
      background: radial-gradient(circle, rgba(212,168,67,0.04) 0%, transparent 70%);
      border-radius: 50%;
      pointer-events: none;
      z-index: 9998;
      transform: translate(-50%, -50%);
      transition: left 0.3s ease, top 0.3s ease;
    `;
    document.body.appendChild(glow);

    document.addEventListener('mousemove', (e) => {
      glow.style.left = e.clientX + 'px';
      glow.style.top = e.clientY + 'px';
    });
  }

  // ---------- CINEMATIC PLAY BUTTON INTERACTION ----------
  document.querySelectorAll('.cinematic-card').forEach(card => {
    card.addEventListener('click', () => {
      // Show a subtle notification since these are preview cards
      const playBtn = card.querySelector('.play-btn');
      if (playBtn) {
        playBtn.style.transform = 'scale(1.3)';
        playBtn.style.borderColor = 'var(--gold-300)';
        playBtn.style.background = 'rgba(212, 168, 67, 0.25)';

        setTimeout(() => {
          playBtn.style.transform = '';
          playBtn.style.borderColor = '';
          playBtn.style.background = '';
        }, 600);
      }
    });
  });

  // ---------- COLLECTION CARDS TILT EFFECT ----------
  if (window.innerWidth > 1024) {
    document.querySelectorAll('.collection-card').forEach(card => {
      card.addEventListener('mousemove', (e) => {
        const rect = card.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const y = e.clientY - rect.top;
        const centerX = rect.width / 2;
        const centerY = rect.height / 2;
        const rotateX = (y - centerY) / 20;
        const rotateY = (centerX - x) / 20;

        card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale(1.02)`;
        card.style.transition = 'transform 0.1s ease';
      });

      card.addEventListener('mouseleave', () => {
        card.style.transform = 'perspective(1000px) rotateX(0) rotateY(0) scale(1)';
        card.style.transition = 'transform 0.5s ease';
      });
    });
  }

  // ---------- NAVBAR ACTIVE LINK ON SCROLL ----------
  const sections = document.querySelectorAll('section[id]');

  const sectionObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const id = entry.target.getAttribute('id');
        document.querySelectorAll('.nav-links a').forEach(link => {
          link.style.color = '';
          if (link.getAttribute('href') === `#${id}`) {
            link.style.color = 'var(--gold-300)';
          }
        });
      }
    });
  }, {
    threshold: 0.3,
    rootMargin: '-80px 0px -50% 0px'
  });

  sections.forEach(section => sectionObserver.observe(section));

  // ---------- IMAGE LAZY LOADING ----------
  const lazyImages = document.querySelectorAll('img[src]');
  if ('loading' in HTMLImageElement.prototype) {
    lazyImages.forEach(img => {
      img.loading = 'lazy';
    });
  }

  // ---------- PERFORMANCE: Throttle scroll events ----------
  let ticking = false;
  window.addEventListener('scroll', () => {
    if (!ticking) {
      window.requestAnimationFrame(() => {
        handleScroll();
        ticking = false;
      });
      ticking = true;
    }
  }, { passive: true });

});
