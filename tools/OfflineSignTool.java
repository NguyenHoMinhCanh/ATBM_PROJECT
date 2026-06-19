import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.nio.file.Files;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

public class OfflineSignTool extends JFrame {

    private JTextArea txtData;
    private JTextField txtKeyPath;
    private JTextArea txtSignature;
    private PrivateKey privateKey;
    private File currentKeyFile;

    public OfflineSignTool() {
        setTitle("Công cụ Ký điện tử Offline");
        setSize(600, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }

        JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));
        mainPanel.setBorder(new EmptyBorder(15, 15, 15, 15));

        // 1. Ô "text" (Nội dung cần ký)
        JLabel lblText = new JLabel("text (Nội dung cần ký)");
        lblText.setAlignmentX(Component.LEFT_ALIGNMENT);
        txtData = new JTextArea(5, 50);
        txtData.setLineWrap(true);
        JScrollPane scrollData = new JScrollPane(txtData);
        scrollData.setAlignmentX(Component.LEFT_ALIGNMENT);
        
        // 2. Ô "key" và nút [...]
        JPanel keyPanel = new JPanel();
        keyPanel.setLayout(new BoxLayout(keyPanel, BoxLayout.X_AXIS));
        keyPanel.setAlignmentX(Component.LEFT_ALIGNMENT);
        
        txtKeyPath = new JTextField("key (Đường dẫn Private Key)");
        txtKeyPath.setEditable(false);
        txtKeyPath.setMaximumSize(new Dimension(Integer.MAX_VALUE, 30));
        
        JButton btnBrowse = new JButton("...");
        btnBrowse.setPreferredSize(new Dimension(40, 30));
        
        keyPanel.add(txtKeyPath);
        keyPanel.add(Box.createRigidArea(new Dimension(10, 0)));
        keyPanel.add(btnBrowse);
        
        // 3. Nút "Ký"
        JPanel signPanel = new JPanel();
        signPanel.setLayout(new FlowLayout(FlowLayout.CENTER));
        signPanel.setAlignmentX(Component.LEFT_ALIGNMENT);
        JButton btnSign = new JButton("Ký");
        btnSign.setPreferredSize(new Dimension(150, 40));
        btnSign.setFont(new Font("Arial", Font.BOLD, 14));
        signPanel.add(btnSign);
        
        // 4. Ô "chữ ký Base64"
        JLabel lblSignature = new JLabel("Chữ ký Base64");
        lblSignature.setAlignmentX(Component.LEFT_ALIGNMENT);
        txtSignature = new JTextArea(5, 50);
        txtSignature.setLineWrap(true);
        txtSignature.setEditable(false);
        txtSignature.setBackground(new Color(245, 245, 245));
        JScrollPane scrollSign = new JScrollPane(txtSignature);
        scrollSign.setAlignmentX(Component.LEFT_ALIGNMENT);

        // Thêm vào mainPanel với khoảng cách
        mainPanel.add(lblText);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 5)));
        mainPanel.add(scrollData);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 15)));
        mainPanel.add(keyPanel);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 15)));
        mainPanel.add(signPanel);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 15)));
        mainPanel.add(lblSignature);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 5)));
        mainPanel.add(scrollSign);

        add(mainPanel);

        // Xử lý sự kiện nút "..."
        btnBrowse.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                loadPrivateKey();
            }
        });

        // Xử lý sự kiện nút "Ký"
        btnSign.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                signData();
            }
        });
    }

    private void loadPrivateKey() {
        JFileChooser fileChooser = new JFileChooser();
        int result = fileChooser.showOpenDialog(this);
        if (result == JFileChooser.APPROVE_OPTION) {
            currentKeyFile = fileChooser.getSelectedFile();
            try {
                String keyStr = new String(Files.readAllBytes(currentKeyFile.toPath()));
                keyStr = keyStr.replaceAll("-----BEGIN PRIVATE KEY-----", "")
                               .replaceAll("-----END PRIVATE KEY-----", "")
                               .replaceAll("\\s+", "");

                byte[] keyBytes = Base64.getDecoder().decode(keyStr);
                PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
                KeyFactory kf = KeyFactory.getInstance("RSA");
                privateKey = kf.generatePrivate(spec);
                
                txtKeyPath.setText(currentKeyFile.getAbsolutePath());
                txtSignature.setText("");
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(this, "Lỗi đọc file khóa: " + ex.getMessage(), "Lỗi", JOptionPane.ERROR_MESSAGE);
                privateKey = null;
                txtKeyPath.setText("Lỗi khóa!");
            }
        }
    }

    private void signData() {
        if (privateKey == null) {
            JOptionPane.showMessageDialog(this, "Vui lòng chọn file Private Key (key) trước!", "Lỗi", JOptionPane.ERROR_MESSAGE);
            return;
        }

        String data = txtData.getText().trim();
        if (data.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Vui lòng nhập nội dung (text) cần ký!", "Lỗi", JOptionPane.WARNING_MESSAGE);
            return;
        }

        try {
            Signature signature = Signature.getInstance("SHA256withRSA");
            signature.initSign(privateKey);
            signature.update(data.getBytes("UTF-8"));
            byte[] signatureBytes = signature.sign();
            
            String encodedSignature = Base64.getEncoder().encodeToString(signatureBytes);
            txtSignature.setText(encodedSignature);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, "Lỗi khi tạo chữ ký: " + ex.getMessage(), "Lỗi", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new OfflineSignTool().setVisible(true);
            }
        });
    }
}
