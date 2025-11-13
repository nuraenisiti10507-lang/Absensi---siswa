<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Absensi Siswa SMAN 1 Parakansalak</title>
  <style>
    body {
      font-family: "Poppins", sans-serif;
      background: linear-gradient(to bottom right, #90caf9, #e1f5fe);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .container {
      background: white;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      width: 320px;
    }
    h2 {
      text-align: center;
      color: #0277bd;
    }
    input, select, button {
      width: 100%;
      padding: 10px;
      margin: 8px 0;
      border: 1px solid #90caf9;
      border-radius: 6px;
      font-size: 15px;
    }
    button {
      background-color: #0288d1;
      color: white;
      border: none;
      cursor: pointer;
      transition: 0.3s;
    }
    button:hover {
      background-color: #0277bd;
    }
    #status {
      text-align: center;
      margin-top: 10px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Form Absensi</h2>
    <form id="absensiForm">
      <input type="text" id="nama" placeholder="Nama Lengkap" required />
      <input type="text" id="kelas" placeholder="Kelas (misal: XII IPA 1)" required />
      <select id="keterangan" required>
        <option value="">-- Pilih Keterangan --</option>
        <option value="Hadir">Hadir</option>
        <option value="Izin">Izin</option>
        <option value="Sakit">Sakit</option>
        <option value="Alpa">Alpa</option>
      </select>
      <button type="submit">Kirim</button>
    </form>
    <p id="status"></p>
  </div>

  <script>
    const SCRIPT_URL = "https://script.google.com/macros/s/AKfycbyYLrDGSC5JnLfHSowpYR3rWqtmjdhwSXG5f_w3Cp7hf21D6BFB9Ymh9MYFmfC5mmmqKQ/exec"; // ganti dengan URL dari langkah 3

    document.getElementById("absensiForm").addEventListener("submit", (e) => {
      e.preventDefault();
      const nama = document.getElementById("nama").value;
      const kelas = document.getElementById("kelas").value;
      const keterangan = document.getElementById("keterangan").value;

      fetch(SCRIPT_URL, {
        method: "POST",
        body: JSON.stringify({ nama, kelas, keterangan }),
        headers: { "Content-Type": "application/json" },
      })
        .then((res) => res.text())
        .then(() => {
          document.getElementById("status").innerText = "✅ Data berhasil dikirim!";
          document.getElementById("absensiForm").reset();
        })
        .catch(() => {
          document.getElementById("status").innerText = "❌ Gagal mengirim data!";
        });
    });
  </script>
</body>
</html>
