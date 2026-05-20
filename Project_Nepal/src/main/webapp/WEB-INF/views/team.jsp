<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Team</title>
  <link rel="stylesheet" href="https://unpkg.com/98.css"/>
  <link href="https://fonts.googleapis.com/css2?family=VT323&family=Orbitron:wght@700;900&display=swap" rel="stylesheet"/>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      min-height: 100vh;
      overflow: hidden;
      font-family: 'Arial', sans-serif;
      position: relative;
      background: #000;
    }

    #bg-canvas {
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      z-index: 0;
    }

    .progress-indicator.segmented {
      height: 20px;
    }
    .progress-indicator.segmented > .progress-indicator-bar {
      height: 100%;
      background: #000080;
      background-image: repeating-linear-gradient(
        90deg,
        #000080 0px,
        #000080 16px,
        transparent 16px,
        transparent 20px
      );
    }

    .desktop-icons, .taskbar, .win98 { position: relative; z-index: 10; }

    .taskbar {
      position: fixed;
      bottom: 0; left: 0; right: 0;
      height: 36px;
      background: #c0c0c0;
      border-top: 2px solid #fff;
      display: flex;
      align-items: center;
      padding: 0 4px;
      gap: 4px;
      z-index: 9999;
    }
    .start-btn {
      display: flex;
      align-items: center;
      gap: 4px;
      padding: 2px 8px;
      font-weight: 700;
      font-size: 13px;
      border-top: 2px solid #fff;
      border-left: 2px solid #fff;
      border-bottom: 2px solid #444;
      border-right: 2px solid #444;
      background: #c0c0c0;
      cursor: pointer;
    }
    .start-btn:active {
      border-top: 2px solid #444;
      border-left: 2px solid #444;
      border-bottom: 2px solid #fff;
      border-right: 2px solid #fff;
    }
    .taskbar-clock {
      margin-left: auto;
      padding: 2px 8px;
      font-size: 12px;
      border-top: 2px solid #444;
      border-left: 2px solid #444;
      border-bottom: 2px solid #fff;
      border-right: 2px solid #fff;
    }
    .taskbar-btn {
      padding: 2px 10px;
      font-size: 11px;
      max-width: 150px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      cursor: pointer;
      border-top: 2px solid #fff;
      border-left: 2px solid #fff;
      border-bottom: 2px solid #444;
      border-right: 2px solid #444;
      background: #c0c0c0;
    }

    .desktop-icons {
      position: fixed;
      top: 8px; left: 8px;
      display: flex;
      flex-direction: column;
      gap: 16px;
      z-index: 100;
    }
    .desktop-icon {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 4px;
      width: 64px;
      cursor: pointer;
      padding: 4px;
    }
    .desktop-icon:hover .icon-label { background: #000080; color: #fff; }

    .icon-img {
      width: 32px; height: 32px;
      image-rendering: pixelated;
      display: flex; align-items: center; justify-content: center;
      font-size: 26px;
      line-height: 1;
    }
    .icon-label {
      font-size: 11px;
      color: #fff;
      text-align: center;
      text-shadow: 1px 1px #000;
      padding: 1px 3px;
      word-break: break-word;
    }

    .win98 {
      position: absolute;
      min-width: 200px;
      cursor: default;
      user-select: none;
      z-index: 200;
    }
    .win98 .title-bar { cursor: grab; }
    .win98 .title-bar:active { cursor: grabbing; }

    .crew-avatar-img {
      width: 80px; height: 80px;
      border: 3px solid #444;
      border-top: 3px solid #fff;
      border-left: 3px solid #fff;
      object-fit: cover;
      background: #c0c0c0;
      display: flex; align-items: center; justify-content: center;
      font-family: 'VT323', monospace;
      font-size: .8rem;
      color: #808080;
      overflow: hidden;
      flex-shrink: 0;
    }
    .crew-avatar-img img {
      width: 100%; height: 100%;
      object-fit: cover;
      display: block;
    }

    .gif-placeholder {
      width: 100%;
      height: 140px;
      background: #000;
      border: 2px inset #808080;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #00ff00;
      font-family: 'VT323', monospace;
      font-size: 1rem;
      text-align: center;
      overflow: hidden;
    }
    .gif-placeholder img { width: 100%; height: 100%; object-fit: cover; }

    @keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
    .vinyl {
      width: 60px; height: 60px;
      border-radius: 50%;
      background: radial-gradient(circle,
        #222 0%, #222 18%, #111 18%, #111 20%,
        #333 20%, #1a1a1a 38%, #111 38%, #111 40%,
        #2a2a2a 40%, #1a1a1a 58%, #111 58%, #111 60%,
        #333 60%, #1a1a1a 78%, #111 78%, #222 100%
      );
      border: 3px solid #333;
      animation: spin 2s linear infinite;
      flex-shrink: 0;
      position: relative;
    }
    .vinyl::after {
      content: '';
      position: absolute;
      top: 50%; left: 50%;
      transform: translate(-50%,-50%);
      width: 12px; height: 12px;
      border-radius: 50%;
      background: #c0392b;
    }
    .vinyl.paused { animation-play-state: paused; }

    .crew-inner {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 6px;
      padding: 8px;
      text-align: center;
    }
    .crew-name-98 {
      font-family: 'Orbitron', monospace;
      font-size: .75rem;
      font-weight: 700;
    }
    .crew-role-98 {
      font-family: 'VT323', monospace;
      font-size: 1rem;
      color: #000080;
    }
    .crew-bio-98 {
      font-size: 11px;
      color: #444;
      line-height: 1.5;
      text-align: left;
      border-top: 1px solid #808080;
      padding-top: 6px;
      margin-top: 4px;
    }

    audio { width: 100%; }

    .now-playing-row {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 6px;
    }
    .np-info { flex: 1; overflow: hidden; }
    .np-song {
      font-family: 'VT323', monospace;
      font-size: 1.1rem;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      color: #000080;
    }
    .np-artist { font-size: 11px; color: #444; }

    .marquee-wrap {
      overflow: hidden;
      background: #000080;
      color: #fff;
      font-family: 'VT323', monospace;
      font-size: 1rem;
      padding: 2px 6px;
      letter-spacing: .05em;
    }
    @keyframes marquee { from { transform: translateX(100%); } to { transform: translateX(-100%); } }
    .marquee-inner { display: inline-block; animation: marquee 18s linear infinite; white-space: nowrap; }

    @keyframes blink { 0%,100%{opacity:1} 50%{opacity:0} }
    .blink { animation: blink 1s step-end infinite; }

    /* ── MUSIC PLAYER CONTROLS ── */
    .player-controls {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 6px;
      padding: 6px 8px 4px;
    }
    .ctrl-btn {
      display: flex;
      align-items: center;
      justify-content: center;
      min-width: 36px;
      height: 28px;
      padding: 2px 8px;
      font-size: 13px;
      cursor: pointer;
      background: #c0c0c0;
      border-top: 2px solid #fff;
      border-left: 2px solid #fff;
      border-bottom: 2px solid #444;
      border-right: 2px solid #444;
      transition: border .05s;
      font-family: monospace;
      user-select: none;
    }
    .ctrl-btn:active {
      border-top: 2px solid #444;
      border-left: 2px solid #444;
      border-bottom: 2px solid #fff;
      border-right: 2px solid #fff;
    }
    .ctrl-btn.play-pause { min-width: 48px; font-size: 15px; }

    /* ── PLAYLIST ── */
    .playlist-wrap {
      border: 2px inset #808080;
      margin: 4px 8px 6px;
      background: #fff;
      max-height: 120px;
      overflow-y: auto;
    }
    .playlist-item {
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 3px 6px;
      font-size: 11px;
      cursor: pointer;
      border-bottom: 1px solid #e0e0e0;
      font-family: 'VT323', monospace;
      font-size: 1rem;
      color: #333;
    }
    .playlist-item:last-child { border-bottom: none; }
    .playlist-item:hover { background: #000080; color: #fff; }
    .playlist-item.active { background: #000080; color: #fff; }
    .playlist-item .track-num {
      color: #808080;
      min-width: 16px;
      font-size: .85rem;
    }
    .playlist-item.active .track-num { color: #aaaaff; }
    .playlist-item .track-duration {
      margin-left: auto;
      font-size: .8rem;
      color: #808080;
      white-space: nowrap;
    }
    .playlist-item.active .track-duration { color: #aaaaff; }

    /* RPS */
    .rps-btn {
      font-size: 2rem;
      padding: 8px 16px;
      cursor: pointer;
      background: #c0c0c0;
      border-top: 2px solid #fff;
      border-left: 2px solid #fff;
      border-bottom: 2px solid #444;
      border-right: 2px solid #444;
      transition: border .05s;
    }
    .rps-btn:active {
      border-top: 2px solid #444;
      border-left: 2px solid #444;
      border-bottom: 2px solid #fff;
      border-right: 2px solid #fff;
    }
    .rps-result {
      font-family: 'VT323', monospace;
      font-size: 1.3rem;
      text-align: center;
      min-height: 28px;
      color: #000080;
    }
    .rps-score {
      font-size: 11px;
      text-align: center;
      color: #444;
      margin-top: 4px;
    }
    .rps-vs {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 20px;
      font-size: 2.5rem;
      margin: 8px 0;
    }
    .rps-label {
      font-size: 10px;
      text-align: center;
      color: #808080;
      font-family: 'VT323', monospace;
    }

    .company-stat-boxes {
      display: flex;
      gap: 6px;
      margin-top: 10px;
    }
    .company-stat-box {
      flex: 1;
      border: 2px inset #808080;
      padding: 6px 4px;
      text-align: center;
      background: #fff;
    }
    .company-stat-num {
      font-family: 'Orbitron', monospace;
      font-size: .75rem;
      font-weight: 900;
      color: #000080;
    }
    .company-stat-label {
      font-size: 9px;
      color: #808080;
      margin-top: 2px;
    }
    .company-tab-active {
      border-top: 2px solid #444 !important;
      border-left: 2px solid #444 !important;
      border-bottom: 2px solid #fff !important;
      border-right: 2px solid #fff !important;
    }
  </style>
</head>
<body>

  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value="team"/>
  </jsp:include>

  <canvas id="bg-canvas"></canvas>

  <div class="desktop-icons">
    <div class="desktop-icon" ondblclick="showWindow('win-music')">
      <div class="icon-img">🕹️</div>
      <div class="icon-label">Now Playing</div>
    </div>
    <div class="desktop-icon" ondblclick="showWindow('win-crew1')">
      <div class="icon-img">👾</div>
      <div class="icon-label">Ayush Rai</div>
    </div>
    <div class="desktop-icon" ondblclick="showWindow('win-crew2')">
      <div class="icon-img">🎮</div>
      <div class="icon-label">Amitabh</div>
    </div>
    <div class="desktop-icon" ondblclick="showWindow('win-crew3')">
      <div class="icon-img">🔮</div>
      <div class="icon-label">Rising</div>
    </div>
    <div class="desktop-icon" ondblclick="window.location='${pageContext.request.contextPath}/home'">
      <div class="icon-img">🏠</div>
      <div class="icon-label">Grand Their Auto</div>
    </div>
    <div class="desktop-icon" ondblclick="showWindow('win-rps')">
      <div class="icon-img">🎲</div>
      <div class="icon-label">Mini Game</div>
    </div>
    <div class="desktop-icon" ondblclick="showWindow('win-company')">
      <div class="icon-img">🏢</div>
      <div class="icon-label">Company</div>
    </div>
  </div>

  <%-- ══════════════════════════════════════════
       WINDOW 1 — Now Playing  (UPDATED)
  ══════════════════════════════════════════ --%>
  <div class="window win98" id="win-music" style="width:420px; left:300px; top:60px;">
    <div class="title-bar">
      <div class="title-bar-text">🎵 Jazz Fusion FM — Kathmandu, NP</div>
      <div class="title-bar-controls">
        <button aria-label="Minimize" onclick="hideWindow('win-music')"></button>
        <button aria-label="Maximize" disabled></button>
        <button aria-label="Close" onclick="hideWindow('win-music')"></button>
      </div>
    </div>

    <%-- Marquee --%>
    <div class="window-body" style="padding:0;">
      <div class="marquee-wrap">
        <span class="marquee-inner" id="marquee-text">
          >>>>>>> CASIOPEA >>>>>>> ♪ SWALLOW ♪ >>>>>>> JAZZ FUSION FM >>>>>>> KATHMANDU NP >>>>>>>
        </span>
      </div>
    </div>

    <%-- Vinyl + track info --%>
    <div class="window-body" style="padding:4px 8px;">
      <div class="now-playing-row">
        <div class="vinyl paused" id="vinyl"></div>
        <div class="np-info">
          <div class="np-song" id="npSong">スワロー (Swallow)</div>
          <div class="np-artist" id="npArtist">— Casiopea —</div>
          <div style="font-size:10px; color:#808080; margin-top:2px;" id="npTrackNum">Track 1 / 5</div>
        </div>
      </div>
    </div>

    <%-- Hidden audio element --%>
    <audio id="audioPlayer" style="display:none;"></audio>

    <%-- Progress bar --%>
    <div class="window-body" style="padding: 2px 8px 4px;">
      <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:3px;">
        <span style="font-family:'VT323',monospace; font-size:.9rem; color:#000080;">
          <span class="blink">●</span> LIVE &nbsp;·&nbsp; Jazz Fusion FM &nbsp;·&nbsp; Kathmandu, NP
        </span>
        <span style="font-size:10px; color:#808080;" id="npTime">0:00 / 0:00</span>
      </div>
      <div class="progress-indicator segmented" style="height: 18px; width: 100%; cursor: pointer;" id="progress-bar-wrap" onclick="seekAudio(event)">
        <span class="progress-indicator-bar" id="audio-progress-bar" style="width: 0%; height: 100%;"></span>
      </div>
    </div>

    <%-- Transport controls --%>
    <div class="window-body" style="padding:4px 8px 8px;">
      <div class="player-controls">
        <button class="ctrl-btn" onclick="prevTrack()" title="Previous">⏮</button>
        <button class="ctrl-btn" onclick="skipBack10()" title="Rewind 10s">⏪</button>
        <button class="ctrl-btn play-pause" id="playPauseBtn" onclick="togglePlayPause()" title="Play / Pause">▶</button>
        <button class="ctrl-btn" onclick="skipForward10()" title="Forward 10s">⏩</button>
        <button class="ctrl-btn" onclick="nextTrack()" title="Next">⏭</button>
        <button class="ctrl-btn" id="shuffleBtn" onclick="toggleShuffle()" title="Shuffle" style="margin-left:4px; font-size:11px;">🔀</button>
        <button class="ctrl-btn" id="loopBtn" onclick="toggleLoop()" title="Loop" style="font-size:11px;">🔁</button>
      </div>
    </div>

    <%-- Volume --%>
    <div class="window-body" style="padding:0 8px 6px; display:flex; align-items:center; gap:8px;">
      <span style="font-size:11px; font-family:'VT323',monospace;">VOL</span>
      <input type="range" id="volumeSlider" min="0" max="100" value="80"
             style="flex:1; height:16px; cursor:pointer; accent-color:#000080;"
             oninput="setVolume(this.value)" />
      <span style="font-size:10px; color:#808080; min-width:28px;" id="volLabel">80%</span>
    </div>

    <%-- Playlist --%>
    <div class="window-body" style="padding:0 0 4px;">
      <div style="background:#000080; color:#fff; font-family:'VT323',monospace; font-size:.95rem; padding:2px 8px; display:flex; justify-content:space-between;">
        <span>PLAYLIST</span>
        <span style="font-size:.8rem; opacity:.7;">dbl-click to play</span>
      </div>
      <div class="playlist-wrap" id="playlist-wrap">
        <%-- Populated by JS --%>
      </div>
    </div>

    <div class="status-bar">
      <p class="status-bar-field" id="player-status">Ready</p>
      <p class="status-bar-field" id="player-mode">Normal</p>
    </div>
  </div>

  <%-- ══════════════════════════════════════════
       WINDOW 2 — Crew Member 1
  ══════════════════════════════════════════ --%>
  <div class="window win98" id="win-crew1" style="width:320px; left:80px; top:180px;">
    <div class="title-bar">
      <div class="title-bar-text">👾 Kulung</div>
      <div class="title-bar-controls">
        <button aria-label="Minimize" onclick="hideWindow('win-crew1')"></button>
        <button aria-label="Close" onclick="hideWindow('win-crew1')"></button>
      </div>
    </div>
    <div class="window-body">
      <div class="crew-inner">
        <div class="crew-avatar-img">
          <img src="${pageContext.request.contextPath}/images/kulung.jpg"
               onerror="this.parentNode.innerHTML='[ no photo ]'"
               alt="Ayush Rai"/>
        </div>
        <div class="crew-name-98">Ayush Rai</div>
        <div class="crew-role-98">Designer / Coding</div>
        <div class="crew-bio-98">
          Coolest of the coolest alpha wolf the one and only idk...-insert self glaze here-
        </div>
      </div>
    </div>
  </div>

  <%-- ══════════════════════════════════════════
       WINDOW 3 — Crew Member 2
  ══════════════════════════════════════════ --%>
  <div class="window win98" id="win-crew2" style="width:320px; left:700px; top:120px;">
    <div class="title-bar">
      <div class="title-bar-text">🎮 Amitabh bacchan</div>
      <div class="title-bar-controls">
        <button aria-label="Minimize" onclick="hideWindow('win-crew2')"></button>
        <button aria-label="Close" onclick="hideWindow('win-crew2')"></button>
      </div>
    </div>
    <div class="window-body">
      <div class="crew-inner">
        <div class="crew-avatar-img">
          <img src="${pageContext.request.contextPath}/images/amitabh.jpg"
               onerror="this.parentNode.innerHTML='[ no photo ]'"
               alt="Amitabh Manandhar"/>
        </div>
        <div class="crew-name-98">Amitabh Manandhar</div>
        <div class="crew-role-98">The Organiser</div>
        <div class="crew-bio-98">
          Organizes so much even the cells inside his body are neat. Drinks neat! And not to mention his hair — Neat!
        </div>
      </div>
    </div>
  </div>

  <%-- ══════════════════════════════════════════
       WINDOW 4 — Crew Member 3
  ══════════════════════════════════════════ --%>
  <div class="window win98" id="win-crew3" style="width:320px; left:700px; top:430px;">
    <div class="title-bar">
      <div class="title-bar-text">🔮 Risen</div>
      <div class="title-bar-controls">
        <button aria-label="Minimize" onclick="hideWindow('win-crew3')"></button>
        <button aria-label="Close" onclick="hideWindow('win-crew3')"></button>
      </div>
    </div>
    <div class="window-body">
      <div class="crew-inner">
        <div class="crew-avatar-img">
          <img src="${pageContext.request.contextPath}/images/rising.jpg"
               onerror="this.parentNode.innerHTML='[ no photo ]'"
               alt="Rising Maharjan"/>
        </div>
        <div class="crew-name-98">Rising Maharjan</div>
        <div class="crew-role-98">The Lonely Wanderer</div>
        <div class="crew-bio-98">
          Wandered the streets from a very young age. Looks like he has not been out of it to this very day — we are scrambling to even meet him...
        </div>
      </div>
    </div>
  </div>

  <%-- ══════════════════════════════════════════
       WINDOW 5 — Error / Welcome popup
  ══════════════════════════════════════════ --%>
  <div class="window win98" id="win-error" style="width:300px; left:380px; top:420px;">
    <div class="title-bar">
      <div class="title-bar-text">⚠️ Important Message</div>
      <div class="title-bar-controls">
        <button aria-label="Close" onclick="hideWindow('win-error')"></button>
      </div>
    </div>
    <div class="window-body" style="text-align:center; padding:16px;">
      <p style="font-size:13px; margin-bottom:12px;">
        You have been selected to join the most epic Nepal adventure ever conceived by human beings.
      </p>
      <p style="font-size:11px; color:#808080; margin-bottom:16px;">
        This is not a drill. <span class="blink">⚠️ Please respond! ⚠️</span>
      </p>
      <div style="display:flex; gap:8px; justify-content:center;">
        <button class="default" onclick="hideWindow('win-error')">OK</button>
        <button onclick="hideWindow('win-error')">Hell Yea</button>
      </div>
    </div>
  </div>

  <%-- ══════════════════════════════════════════
       WINDOW 6 — Rock Paper Scissors
  ══════════════════════════════════════════ --%>
  <div class="window win98" id="win-rps" style="width:340px; left:420px; top:160px; display:none;">
    <div class="title-bar">
      <div class="title-bar-text">🎲 Rock Paper Scissors</div>
      <div class="title-bar-controls">
        <button aria-label="Close" onclick="hideWindow('win-rps')"></button>
      </div>
    </div>
    <div class="window-body" style="padding:12px;">
      <p style="font-size:11px; text-align:center; margin-bottom:8px; font-family:'VT323',monospace; font-size:1.1rem;">Choose your weapon:</p>
      <div style="display:flex; justify-content:center; gap:10px; margin-bottom:10px;">
        <div>
          <button class="rps-btn" onclick="playRPS(1)" title="Rock">🪨</button>
          <div class="rps-label">ROCK</div>
        </div>
        <div>
          <button class="rps-btn" onclick="playRPS(2)" title="Paper">📄</button>
          <div class="rps-label">PAPER</div>
        </div>
        <div>
          <button class="rps-btn" onclick="playRPS(3)" title="Scissors">✂️</button>
          <div class="rps-label">SCISSORS</div>
        </div>
      </div>
      <div class="rps-vs" id="rps-vs">
        <div>
          <div id="rps-player-emoji" style="font-size:2.5rem;">❓</div>
          <div class="rps-label">YOU</div>
        </div>
        <div style="font-family:'VT323',monospace; font-size:1.4rem; color:#808080;">VS</div>
        <div>
          <div id="rps-cpu-emoji" style="font-size:2.5rem;">❓</div>
          <div class="rps-label">CPU</div>
        </div>
      </div>
      <div class="rps-result" id="rps-result">Pick something!</div>
      <div class="rps-score" id="rps-score">W: 0 &nbsp;|&nbsp; L: 0 &nbsp;|&nbsp; D: 0</div>
      <div style="text-align:center; margin-top:8px;">
        <button onclick="resetRPS()" style="font-size:11px;">Reset Score</button>
      </div>
    </div>
    <div class="status-bar">
      <p class="status-bar-field" id="rps-status">Ready</p>
    </div>
  </div>

  <%-- ── GIF windows ── --%>
  <div class="window win98" id="win-gif1" style="width:240px; left:60px; top:500px;">
    <div class="title-bar">
      <div class="title-bar-text">Media-Player</div>
      <div class="title-bar-controls">
        <button aria-label="Close" onclick="hideWindow('win-gif1')"></button>
      </div>
    </div>
    <div class="window-body" style="padding:4px;">
      <div class="gif-placeholder">
        <img src="https://d2w9rnfcy7mm78.cloudfront.net/9916388/original_17ea2c3af34e1ff95bda5a7cc7f0eb16.gif?1608103864" alt="man-run"/>
      </div>
    </div>
    <div class="status-bar"><p class="status-bar-field">Man-Run</p></div>
  </div>

  <div class="window win98" id="win-gif2" style="width:240px; left:980px; top:80px;">
    <div class="title-bar">
      <div class="title-bar-text">Star Warfare</div>
      <div class="title-bar-controls">
        <button aria-label="Close" onclick="hideWindow('win-gif2')"></button>
      </div>
    </div>
    <div class="window-body" style="padding:4px;">
      <div class="gif-placeholder">
        <img src="https://d2w9rnfcy7mm78.cloudfront.net/9916263/original_f2eb1af21ef6e34f5ce778060078753a.gif?1608103469" alt=""/>
      </div>
    </div>
    <div class="status-bar"><p class="status-bar-field">Cool-UFO</p></div>
  </div>

  <div class="window win98" id="win-gif3" style="width:240px; left:980px; top:380px;">
    <div class="title-bar">
      <div class="title-bar-text">DJ</div>
      <div class="title-bar-controls">
        <button aria-label="Close" onclick="hideWindow('win-gif3')"></button>
      </div>
    </div>
    <div class="window-body" style="padding:4px;">
      <div class="gif-placeholder">
        <img src="https://www.picgifs.com/music-graphics/music-graphics/dj/music-graphics-dj-345781.gif" alt=""/>
      </div>
    </div>
    <div class="status-bar"><p class="status-bar-field">Disc-Man</p></div>
  </div>

  <div class="window win98" id="win-gif4" style="width:240px; left:300px; top:540px;">
    <div class="title-bar">
      <div class="title-bar-text">kEWL</div>
      <div class="title-bar-controls">
        <button aria-label="Close" onclick="hideWindow('win-gif4')"></button>
      </div>
    </div>
    <div class="window-body" style="padding:4px;">
      <div class="gif-placeholder">
        <img src="https://www.picgifs.com/music-graphics/music-graphics/rockstar/music-graphics-rockstar-622614.gif" alt=""/>
      </div>
    </div>
    <div class="status-bar"><p class="status-bar-field">Rockstar</p></div>
  </div>

  <div class="window win98" id="win-extra" style="width:220px; left:570px; top:500px;">
    <div class="title-bar">
      <div class="title-bar-text">Notepad</div>
      <div class="title-bar-controls">
        <button aria-label="Close" onclick="hideWindow('win-extra')"></button>
      </div>
    </div>
    <div class="window-body" style="padding:8px;">
      <p style="font-size:11px; font-family:'VT323',monospace; color:#000080; line-height:1.6;">
        TO DO LIST:<br/>
        ✓ build the site<br/>
        ✓ question everything<br/>
        ✓ ship it anyway<br/>
        □ sleep<br/>
        □ touch grass<br/>
        □ call mom
      </p>
    </div>
  </div>

  <%-- ══════════════════════════════════════════
       WINDOW 7 — Company (tabbed)
  ══════════════════════════════════════════ --%>
  <div class="window win98" id="win-company" style="width:500px; left:200px; top:100px; display:none;">
    <div class="title-bar">
      <div class="title-bar-text">🏢 Grand Their Auto — Company</div>
      <div class="title-bar-controls">
        <button aria-label="Minimize" onclick="hideWindow('win-company')"></button>
        <button aria-label="Close" onclick="hideWindow('win-company')"></button>
      </div>
    </div>
    <div class="window-body" style="padding:8px;">
      <div style="display:flex; gap:0; margin-bottom:8px;">
        <button style="flex:1;" onclick="showTab('who')" id="tab-who">Who We Are</button>
        <button style="flex:1;" onclick="showTab('history')" id="tab-history">Our History</button>
        <button style="flex:1;" onclick="showTab('do')" id="tab-do">What We Do</button>
      </div>

      <div id="tab-content-who">
        <p style="font-size:11px; line-height:1.7; margin-bottom:8px;">
          We move people through Nepal. Have done since before Nepal was a concept anyone else cared about.
          Descendants of men who sold mountain passes to strangers. Also rocks. Mostly rocks.<br/><br/>
          Somewhere in 1832 a Babbage visited. Left with a map. We do not discuss this further.
        </p>
        <div style="display:inline-block; border:2px inset #808080; padding:4px 10px; background:#fff; font-family:'Orbitron',monospace; font-size:.7rem; font-weight:700; color:#000080;">
          EST. ~1206 AD
        </div>
      </div>

      <div id="tab-content-history" style="display:none;">
        <table style="width:100%; border-collapse:collapse; font-size:11px;">
          <tbody>
            <tr style="border-bottom:1px solid #c0c0c0;">
              <td style="padding:5px 8px; font-family:'Orbitron',monospace; font-weight:700; font-size:.68rem; color:#000080; white-space:nowrap; vertical-align:top;">1206</td>
              <td style="padding:5px 8px;">Ancestor sells mountain passes. Also rocks. Mostly rocks.</td>
            </tr>
            <tr style="border-bottom:1px solid #c0c0c0;">
              <td style="padding:5px 8px; font-family:'Orbitron',monospace; font-weight:700; font-size:.68rem; color:#000080; white-space:nowrap; vertical-align:top;">1832</td>
              <td style="padding:5px 8px;">Babbage visits. Leaves with map. We do not discuss this further.</td>
            </tr>
            <tr style="border-bottom:1px solid #c0c0c0;">
              <td style="padding:5px 8px; font-family:'Orbitron',monospace; font-weight:700; font-size:.68rem; color:#000080; white-space:nowrap; vertical-align:top;">1934</td>
              <td style="padding:5px 8px;">Earthquake. Lost warehouse, two carts, goat named Economics. Rebuilt in six months.</td>
            </tr>
            <tr style="border-bottom:1px solid #c0c0c0;">
              <td style="padding:5px 8px; font-family:'Orbitron',monospace; font-weight:700; font-size:.68rem; color:#000080; white-space:nowrap; vertical-align:top;">1953</td>
              <td style="padding:5px 8px;">Everest summit. World discovers Nepal. We were unsurprised.</td>
            </tr>
            <tr style="border-bottom:1px solid #c0c0c0;">
              <td style="padding:5px 8px; font-family:'Orbitron',monospace; font-weight:700; font-size:.68rem; color:#000080; white-space:nowrap; vertical-align:top;">1987</td>
              <td style="padding:5px 8px;">Monsoon. 14 yaks. Gone. Company survives on noodles and spite.</td>
            </tr>
            <tr>
              <td style="padding:5px 8px; font-family:'Orbitron',monospace; font-weight:700; font-size:.68rem; color:#000080; white-space:nowrap; vertical-align:top;">2024</td>
              <td style="padding:5px 8px;">Website launches. Rising has not reviewed it. He is probably fine.</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div id="tab-content-do" style="display:none;">
        <table style="width:100%; border-collapse:collapse; font-size:11px; border:1px solid #808080;">
          <thead>
            <tr style="background:#000080; color:#fff;">
              <th style="padding:4px 8px; text-align:left;">Service</th>
              <th style="padding:4px 8px; text-align:left;">Details</th>
            </tr>
          </thead>
          <tbody>
            <tr style="border-bottom:1px solid #c0c0c0;">
              <td style="padding:4px 8px; font-weight:700;">Trekking</td>
              <td style="padding:4px 8px;">Everest, Annapurna, Langtang. All of them.</td>
            </tr>
            <tr style="border-bottom:1px solid #c0c0c0; background:#f0f0f0;">
              <td style="padding:4px 8px; font-weight:700;">City Tours</td>
              <td style="padding:4px 8px;">Kathmandu, Pokhara, Bhaktapur. We know every alley.</td>
            </tr>
            <tr style="border-bottom:1px solid #c0c0c0;">
              <td style="padding:4px 8px; font-weight:700;">Logistics</td>
              <td style="padding:4px 8px;">Permits, transport, accommodation. Handled.</td>
            </tr>
            <tr style="background:#f0f0f0;">
              <td style="padding:4px 8px; font-weight:700;">Custom</td>
              <td style="padding:4px 8px;">You name it. We have probably already done it.</td>
            </tr>
          </tbody>
        </table>
        <div class="company-stat-boxes">
          <div class="company-stat-box">
            <div class="company-stat-num">~1206</div>
            <div class="company-stat-label">Founded</div>
          </div>
          <div class="company-stat-box">
            <div class="company-stat-num">∞</div>
            <div class="company-stat-label">Trips</div>
          </div>
          <div class="company-stat-box">
            <div class="company-stat-num">14</div>
            <div class="company-stat-label">Yaks Lost</div>
          </div>
          <div class="company-stat-box">
            <div class="company-stat-num">0</div>
            <div class="company-stat-label">Momo Complaints</div>
          </div>
        </div>
      </div>
    </div>
    <div class="status-bar">
      <p class="status-bar-field">Est. ~1206 AD</p>
      <p class="status-bar-field">Kathmandu, NP</p>
      <p class="status-bar-field"><span class="blink">●</span> OPEN since forever</p>
    </div>
  </div>

  <%-- ── TASKBAR ── --%>
  <div class="taskbar">
    <div class="start-btn" onclick="showWindow('win-rps')">
      <span>🪟</span> Start
    </div>
    <div class="taskbar-btn" onclick="showWindow('win-music')">🎵 Now Playing</div>
    <div class="taskbar-btn" onclick="showWindow('win-crew1')">👾 Ayush</div>
    <div class="taskbar-btn" onclick="showWindow('win-crew2')">🎮 Amitabh</div>
    <div class="taskbar-btn" onclick="showWindow('win-crew3')">🔮 Risen</div>
    <div class="taskbar-btn" onclick="window.location='${pageContext.request.contextPath}/home'">🏠 Home</div>
    <div class="taskbar-clock" id="clock">00:00</div>
  </div>

  <script>
    /* ═══════════════════════════════════════
       80s ANIMATED BACKGROUND
    ═══════════════════════════════════════ */
    (function() {
      const cv = document.getElementById('bg-canvas');
      const cx = cv.getContext('2d');
      let W, H, t = 0;

      function resize() { W = cv.width = window.innerWidth; H = cv.height = window.innerHeight; }
      resize();
      window.addEventListener('resize', resize);

      const STARS = Array.from({length: 120}, () => ({
        x: Math.random(), y: Math.random() * 0.55,
        r: Math.random() * 1.6 + 0.3, spd: Math.random() * 0.0003 + 0.0001
      }));

      function drawFrame() {
        t += 0.012;
        const sky = cx.createLinearGradient(0, 0, 0, H * 0.65);
        sky.addColorStop(0, '#0a0010'); sky.addColorStop(0.4, '#1a0030'); sky.addColorStop(1, '#ff2060');
        cx.fillStyle = sky; cx.fillRect(0, 0, W, H);
        cx.fillStyle = '#0a0010'; cx.fillRect(0, H * 0.65, W, H * 0.35);

        const sunX = W / 2, sunY = H * 0.62, sunR = H * 0.18;
        const sunGrad = cx.createRadialGradient(sunX, sunY, 0, sunX, sunY, sunR);
        sunGrad.addColorStop(0, '#fff7a0'); sunGrad.addColorStop(0.3, '#ffcc00');
        sunGrad.addColorStop(0.7, '#ff6600'); sunGrad.addColorStop(1, '#ff0055');
        cx.save(); cx.beginPath(); cx.arc(sunX, sunY, sunR, 0, Math.PI * 2);
        cx.fillStyle = sunGrad; cx.fill();
        cx.fillStyle = 'rgba(0,0,0,0.18)';
        for (let sy = sunY - sunR; sy < sunY + sunR; sy += 7) cx.fillRect(sunX - sunR, sy, sunR * 2, 3);
        cx.restore();

        const hglow = cx.createLinearGradient(0, H * 0.58, 0, H * 0.72);
        hglow.addColorStop(0, 'rgba(255,60,120,.55)'); hglow.addColorStop(1, 'rgba(255,60,120,0)');
        cx.fillStyle = hglow; cx.fillRect(0, H * 0.58, W, H * 0.14);

        cx.save();
        const GRID_LINES = 14, VERT_LINES = 16, gy = H * 0.65;
        const vanX = W / 2, vanY = gy;
        const speed = (t * 0.32) % 1;
        cx.strokeStyle = '#ff00cc'; cx.lineWidth = 0.8;
        cx.shadowColor = '#ff00cc'; cx.shadowBlur = 6; cx.globalAlpha = 0.85;
        for (let i = 0; i <= GRID_LINES; i++) {
          const frac = (i / GRID_LINES + speed) % 1;
          const persp = Math.pow(frac, 2.2);
          const ly = gy + (H - gy) * persp;
          if (ly < gy) continue;
          cx.globalAlpha = Math.min(1, frac * 2.5) * 0.85;
          cx.beginPath(); cx.moveTo(0, ly); cx.lineTo(W, ly); cx.stroke();
        }
        cx.globalAlpha = 0.7;
        for (let i = 0; i <= VERT_LINES; i++) {
          const tx = (i / VERT_LINES - 0.5) * 3.5;
          const bx = W / 2 + tx * W * 0.5;
          cx.beginPath(); cx.moveTo(vanX, vanY); cx.lineTo(bx, H); cx.stroke();
        }
        cx.restore();

        cx.save(); cx.fillStyle = '#1a0035'; cx.beginPath(); cx.moveTo(0, H * 0.65);
        [[0.05,0.42],[0.12,0.30],[0.20,0.44],[0.28,0.25],[0.36,0.38],[0.43,0.20],
         [0.50,0.35],[0.57,0.22],[0.64,0.38],[0.72,0.28],[0.80,0.42],[0.88,0.32],
         [0.95,0.44],[1.0,0.38]].forEach(([px,py]) => cx.lineTo(W*px, H*py));
        cx.lineTo(W, H * 0.65); cx.closePath(); cx.fill(); cx.restore();

        cx.save();
        STARS.forEach(s => {
          s.x -= s.spd; if (s.x < 0) { s.x = 1; s.y = Math.random() * 0.5; }
          cx.globalAlpha = 0.5 + 0.5 * Math.sin(t * 2 + s.x * 30);
          cx.fillStyle = Math.random() < 0.15 ? '#ff88ff' : '#ffffff';
          cx.beginPath(); cx.arc(s.x * W, s.y * H, s.r, 0, Math.PI * 2); cx.fill();
        });
        cx.restore();

        cx.save(); cx.fillStyle = 'rgba(0,0,0,0.06)';
        for (let sl = 0; sl < H; sl += 4) cx.fillRect(0, sl, W, 2); cx.restore();

        cx.save(); cx.font = "bold 11px 'VT323', monospace"; cx.fillStyle = '#ff00cc';
        cx.globalAlpha = 0.5 + 0.4 * Math.sin(t * 3);
        cx.fillText('EXPLORE NEPAL // ' + new Date().getFullYear(), 10, H - 46);
        cx.restore();

        requestAnimationFrame(drawFrame);
      }
      drawFrame();
    })();

    /* ═══════════════════════════════════════
       CLOCK
    ═══════════════════════════════════════ */
    function updateClock() {
      const now = new Date();
      document.getElementById('clock').textContent =
        now.getHours().toString().padStart(2,'0') + ':' +
        now.getMinutes().toString().padStart(2,'0');
    }
    updateClock();
    setInterval(updateClock, 10000);

    /* ═══════════════════════════════════════
       WINDOW MANAGEMENT
    ═══════════════════════════════════════ */
    function showWindow(id) {
      const w = document.getElementById(id);
      if (w) { w.style.display = ''; bringToFront(w); }
    }
    function hideWindow(id) {
      const w = document.getElementById(id);
      if (w) w.style.display = 'none';
    }
    let zTop = 500;
    function bringToFront(el) { el.style.zIndex = ++zTop; }
    document.querySelectorAll('.win98').forEach(w => {
      w.addEventListener('mousedown', () => bringToFront(w));
    });

    /* ═══════════════════════════════════════
       DRAG
    ═══════════════════════════════════════ */
    document.querySelectorAll('.win98').forEach(win => {
      const bar = win.querySelector('.title-bar');
      if (!bar) return;
      let dragging = false, ox = 0, oy = 0;
      bar.addEventListener('mousedown', e => {
        if (e.target.tagName === 'BUTTON') return;
        dragging = true;
        const rect = win.getBoundingClientRect();
        ox = e.clientX - rect.left; oy = e.clientY - rect.top;
        bringToFront(win); e.preventDefault();
      });
      document.addEventListener('mousemove', e => {
        if (!dragging) return;
        win.style.left = (e.clientX - ox) + 'px';
        win.style.top  = (e.clientY - oy) + 'px';
      });
      document.addEventListener('mouseup', () => { dragging = false; });
    });

    const PLAYLIST = [
      {
        title : 'スワロー (Swallow)',
        artist: 'Casiopea',
        src   : '${pageContext.request.contextPath}/audio/スワロー.mp3'
      },
      {
        title : 'Brasilian Skies',
        artist: 'Masayoshi Takanaka',
        src   : '${pageContext.request.contextPath}/audio/Brasilian Skies.mp3'
      },
      {
        title : 'Sweet Agnes',
        artist: 'Masayoshi Takanaka',
        src   : '${pageContext.request.contextPath}/audio/Sweet Agnes.mp3'
      },
      {
        title : '香港戀歌',
        artist: 'Sadistics',
        src   : '${pageContext.request.contextPath}/audio/香港戀歌.mp3'
      },
      {
        title : '伊豆甘夏納豆売り',
        artist: 'Masayoshi Takanaka',
        src   : '${pageContext.request.contextPath}/audio/伊豆甘夏納豆売り.mp3'
      }
    ];

    /* ── State ── */
    let currentIdx  = 0;
    let isPlaying   = false;
    let shuffleOn   = false;
    let loopMode    = 'none'; // 'none' | 'one' | 'all'

    const audio     = document.getElementById('audioPlayer');
    const vinyl     = document.getElementById('vinyl');
    const playBtn   = document.getElementById('playPauseBtn');

    /* ── Build playlist UI ── */
    function buildPlaylist() {
      const wrap = document.getElementById('playlist-wrap');
      wrap.innerHTML = '';
      PLAYLIST.forEach((track, i) => {
        const item = document.createElement('div');
        item.className = 'playlist-item' + (i === currentIdx ? ' active' : '');
        item.id = 'pl-item-' + i;
        item.title = 'Double-click to play';
        item.innerHTML =
          '<span class="track-num">' + (i + 1) + '</span>' +
          '<span style="flex:1; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">' +
            track.title + ' <span style="font-size:.8rem; opacity:.7;">— ' + track.artist + '</span>' +
          '</span>' +
          '<span class="track-duration" id="pl-dur-' + i + '">--:--</span>';
        item.addEventListener('dblclick', () => loadTrack(i, true));
        wrap.appendChild(item);
      });
    }

    /* ── Load & optionally play track ── */
    function loadTrack(idx, play) {
      currentIdx = idx;
      const track = PLAYLIST[idx];
      audio.src = track.src;
      audio.load();

      // Update UI
      document.getElementById('npSong').textContent   = track.title;
      document.getElementById('npArtist').textContent = '— ' + track.artist + ' —';
      document.getElementById('npTrackNum').textContent = 'Track ' + (idx + 1) + ' / ' + PLAYLIST.length;

      // Marquee
      const m = PLAYLIST.map(t => '♪ ' + t.title + ' — ' + t.artist + ' ♪').join('  >>>>>>>  ');
      document.getElementById('marquee-text').textContent = '>>>>>>> ' + m + ' >>>>>>>';

      // Playlist highlight
      document.querySelectorAll('.playlist-item').forEach((el, i) => {
        el.classList.toggle('active', i === idx);
      });
      // Scroll active into view
      const activeEl = document.getElementById('pl-item-' + idx);
      if (activeEl) activeEl.scrollIntoView({ block: 'nearest' });

      // Status bar
      document.getElementById('player-status').textContent =
        (play ? '▶ Playing: ' : '⏸ Loaded: ') + track.title;

      if (play) {
        audio.play().then(() => { isPlaying = true; syncPlayBtn(); })
                    .catch(() => {});
      } else {
        isPlaying = false;
        syncPlayBtn();
      }
    }

    function syncPlayBtn() {
      playBtn.textContent = isPlaying ? '⏸' : '▶';
      if (isPlaying) { vinyl.classList.remove('paused'); }
      else           { vinyl.classList.add('paused'); }
    }

    /* ── Controls ── */
    function togglePlayPause() {
      if (audio.readyState === 0) { loadTrack(currentIdx, true); return; }
      if (isPlaying) { audio.pause(); isPlaying = false; }
      else           { audio.play().catch(() => {}); isPlaying = true; }
      syncPlayBtn();
    }

    function nextTrack() {
      let next;
      if (shuffleOn) {
        next = Math.floor(Math.random() * PLAYLIST.length);
      } else {
        next = (currentIdx + 1) % PLAYLIST.length;
      }
      loadTrack(next, isPlaying);
    }

    function prevTrack() {
      // If > 3 s into song, restart it; otherwise go to previous
      if (audio.currentTime > 3) {
        audio.currentTime = 0;
        return;
      }
      let prev;
      if (shuffleOn) {
        prev = Math.floor(Math.random() * PLAYLIST.length);
      } else {
        prev = (currentIdx - 1 + PLAYLIST.length) % PLAYLIST.length;
      }
      loadTrack(prev, isPlaying);
    }

    function skipForward10() { audio.currentTime = Math.min(audio.currentTime + 10, audio.duration || 0); }
    function skipBack10()    { audio.currentTime = Math.max(audio.currentTime - 10, 0); }

    function toggleShuffle() {
      shuffleOn = !shuffleOn;
      document.getElementById('shuffleBtn').style.borderTop =
        shuffleOn ? '2px solid #444' : '';
      document.getElementById('shuffleBtn').style.borderLeft =
        shuffleOn ? '2px solid #444' : '';
      document.getElementById('shuffleBtn').style.borderBottom =
        shuffleOn ? '2px solid #fff' : '';
      document.getElementById('shuffleBtn').style.borderRight =
        shuffleOn ? '2px solid #fff' : '';
      document.getElementById('player-mode').textContent =
        shuffleOn ? '🔀 Shuffle' : (loopMode === 'one' ? '🔂 Loop 1' : loopMode === 'all' ? '🔁 Loop All' : 'Normal');
    }

    function toggleLoop() {
      const modes = ['none', 'one', 'all'];
      loopMode = modes[(modes.indexOf(loopMode) + 1) % modes.length];
      const btn = document.getElementById('loopBtn');
      if (loopMode === 'none') {
        btn.textContent = '🔁'; btn.style.borderTop = ''; btn.style.borderLeft = '';
        btn.style.borderBottom = ''; btn.style.borderRight = '';
        audio.loop = false;
      } else if (loopMode === 'one') {
        btn.textContent = '🔂'; btn.style.borderTop = '2px solid #444';
        btn.style.borderLeft = '2px solid #444'; btn.style.borderBottom = '2px solid #fff';
        btn.style.borderRight = '2px solid #fff'; audio.loop = true;
      } else {
        btn.textContent = '🔁'; btn.style.borderTop = '2px solid #444';
        btn.style.borderLeft = '2px solid #444'; btn.style.borderBottom = '2px solid #fff';
        btn.style.borderRight = '2px solid #fff'; audio.loop = false;
      }
      document.getElementById('player-mode').textContent =
        loopMode === 'one' ? '🔂 Loop 1' : loopMode === 'all' ? '🔁 Loop All' : 'Normal';
    }

    function setVolume(val) {
      audio.volume = val / 100;
      document.getElementById('volLabel').textContent = val + '%';
    }

    /* ── Seek by clicking progress bar ── */
    function seekAudio(e) {
      if (!audio.duration) return;
      const rect = document.getElementById('progress-bar-wrap').getBoundingClientRect();
      const pct = (e.clientX - rect.left) / rect.width;
      audio.currentTime = pct * audio.duration;
    }

    /* ── Format mm:ss ── */
    function fmtTime(s) {
      if (!isFinite(s)) return '--:--';
      const m = Math.floor(s / 60);
      const sec = Math.floor(s % 60).toString().padStart(2, '0');
      return m + ':' + sec;
    }

    /* ── Progress update ── */
    const progressBar = document.getElementById('audio-progress-bar');
    audio.addEventListener('timeupdate', () => {
      if (audio.duration) {
        progressBar.style.width = ((audio.currentTime / audio.duration) * 100) + '%';
        document.getElementById('npTime').textContent =
          fmtTime(audio.currentTime) + ' / ' + fmtTime(audio.duration);
      }
    });

    /* ── Load duration into playlist when metadata ready ── */
    audio.addEventListener('loadedmetadata', () => {
      const dur = document.getElementById('pl-dur-' + currentIdx);
      if (dur) dur.textContent = fmtTime(audio.duration);
    });

    /* ── Track ended ── */
    audio.addEventListener('ended', () => {
      if (loopMode === 'one') { audio.play().catch(() => {}); return; }
      if (loopMode === 'all' || currentIdx < PLAYLIST.length - 1) {
        nextTrack();
      } else {
        isPlaying = false; syncPlayBtn();
        document.getElementById('player-status').textContent = '⏹ Stopped';
      }
    });

    /* ── Vinyl sync ── */
    audio.addEventListener('play',  () => { isPlaying = true;  syncPlayBtn(); });
    audio.addEventListener('pause', () => { isPlaying = false; syncPlayBtn(); });

    /* ── Init ── */
    buildPlaylist();
    loadTrack(0, false);
    audio.volume = 0.8;

    // Try autoplay; fall back to first click
    audio.play().then(() => { isPlaying = true; syncPlayBtn(); })
                .catch(() => {
                  const tryPlay = () => {
                    audio.play().then(() => { isPlaying = true; syncPlayBtn(); }).catch(() => {});
                    document.removeEventListener('click', tryPlay);
                  };
                  document.addEventListener('click', tryPlay);
                });

    /* ═══════════════════════════════════════
       ROCK PAPER SCISSORS
    ═══════════════════════════════════════ */
    const CHOICES = { 1: '🪨', 2: '📄', 3: '✂️' };
    const NAMES   = { 1: 'Rock', 2: 'Paper', 3: 'Scissors' };
    let rpsW = 0, rpsL = 0, rpsD = 0;

    function playRPS(playerPick) {
      const cpuPick = Math.floor(Math.random() * 3) + 1;
      document.getElementById('rps-player-emoji').textContent = CHOICES[playerPick];
      document.getElementById('rps-cpu-emoji').textContent    = CHOICES[cpuPick];
      let result, statusMsg;
      if (playerPick === cpuPick) { result = "It's a DRAW! 🤝"; statusMsg = 'Draw!'; rpsD++; }
      else if ((playerPick===1&&cpuPick===3)||(playerPick===2&&cpuPick===1)||(playerPick===3&&cpuPick===2)) {
        result = 'YOU WIN! 🎉 ' + NAMES[playerPick] + ' beats ' + NAMES[cpuPick]; statusMsg = 'Player wins!'; rpsW++;
      } else {
        result = 'CPU WINS! 💀 ' + NAMES[cpuPick] + ' beats ' + NAMES[playerPick]; statusMsg = 'CPU wins!'; rpsL++;
      }
      document.getElementById('rps-result').textContent = result;
      document.getElementById('rps-status').textContent = statusMsg;
      document.getElementById('rps-score').innerHTML = 'W: '+rpsW+' &nbsp;|&nbsp; L: '+rpsL+' &nbsp;|&nbsp; D: '+rpsD;
    }

    function resetRPS() {
      rpsW = rpsL = rpsD = 0;
      document.getElementById('rps-player-emoji').textContent = '❓';
      document.getElementById('rps-cpu-emoji').textContent    = '❓';
      document.getElementById('rps-result').textContent       = 'Pick something!';
      document.getElementById('rps-status').textContent       = 'Ready';
      document.getElementById('rps-score').innerHTML = 'W: 0 &nbsp;|&nbsp; L: 0 &nbsp;|&nbsp; D: 0';
    }

    /* ═══════════════════════════════════════
       COMPANY WINDOW TABS
    ═══════════════════════════════════════ */
    function showTab(name) {
      ['who','history','do'].forEach(t => {
        document.getElementById('tab-content-' + t).style.display = 'none';
        const btn = document.getElementById('tab-' + t);
        btn.style.borderTop = btn.style.borderLeft = btn.style.borderBottom = btn.style.borderRight = '';
      });
      document.getElementById('tab-content-' + name).style.display = 'block';
      const ab = document.getElementById('tab-' + name);
      ab.style.borderTop = '2px solid #444'; ab.style.borderLeft = '2px solid #444';
      ab.style.borderBottom = '2px solid #fff'; ab.style.borderRight = '2px solid #fff';
    }
    showTab('who');
  </script>

</body>
</html>
