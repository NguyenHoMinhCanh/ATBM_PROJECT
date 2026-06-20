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

    private JTextField txtDataFilePath;
    private JTextField txtKeyPath;
    private JTextArea txtSignature;
    private JTextArea txtDataPreview;
    private PrivateKey privateKey;
    private String orderData;

    public OfflineSignTool() {
        setTitle("Công cụ Ký điện tử Offline - Japan Sport");
        setSize(650, 520);
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

        // 1. Chọn file đơn hàng
        JLabel lblData = new JLabel("Bước 1: Chọn file dữ liệu đơn hàng (.txt)");
        lblData.setFont(new Font("Arial", Font.BOLD, 13));
        lblData.setAlignmentX(Component.LEFT_ALIGNMENT);
        
        JPanel dataPanel = new JPanel();
        dataPanel.setLayout(new BoxLayout(dataPanel, BoxLayout.X_AXIS));
        dataPanel.setAlignmentX(Component.LEFT_ALIGNMENT);
        
        txtDataFilePath = new JTextField("Chưa chọn file đơn hàng...");
        txtDataFilePath.setEditable(false);
        txtDataFilePath.setMaximumSize(new Dimension(Integer.MAX_VALUE, 30));
        
        JButton btnBrowseData = new JButton("...");
        btnBrowseData.setPreferredSize(new Dimension(40, 30));
        
        dataPanel.add(txtDataFilePath);
        dataPanel.add(Box.createRigidArea(new Dimension(10, 0)));
        dataPanel.add(btnBrowseData);

        // Xem trước nội dung file
        JLabel lblPreview = new JLabel("Nội dung file đơn hàng:");
        lblPreview.setAlignmentX(Component.LEFT_ALIGNMENT);
        txtDataPreview = new JTextArea(3, 50);
        txtDataPreview.setLineWrap(true);
        txtDataPreview.setWrapStyleWord(true);
        txtDataPreview.setEditable(false);
        txtDataPreview.setBackground(new Color(240, 248, 255));
        JScrollPane scrollPreview = new JScrollPane(txtDataPreview);
        scrollPreview.setAlignmentX(Component.LEFT_ALIGNMENT);

        // 2. Chọn file Private Key
        JLabel lblKey = new JLabel("Bước 2: Chọn file Private Key (.pem)");
        lblKey.setFont(new Font("Arial", Font.BOLD, 13));
        lblKey.setAlignmentX(Component.LEFT_ALIGNMENT);
        
        JPanel keyPanel = new JPanel();
        keyPanel.setLayout(new BoxLayout(keyPanel, BoxLayout.X_AXIS));
        keyPanel.setAlignmentX(Component.LEFT_ALIGNMENT);
        
        txtKeyPath = new JTextField("Chưa chọn file Private Key...");
        txtKeyPath.setEditable(false);
        txtKeyPath.setMaximumSize(new Dimension(Integer.MAX_VALUE, 30));
        
        JButton btnBrowseKey = new JButton("...");
        btnBrowseKey.setPreferredSize(new Dimension(40, 30));
        
        keyPanel.add(txtKeyPath);
        keyPanel.add(Box.createRigidArea(new Dimension(10, 0)));
        keyPanel.add(btnBrowseKey);
        
        // 3. Nút "Ký"
        JPanel signPanel = new JPanel();
        signPanel.setLayout(new FlowLayout(FlowLayout.CENTER));
        signPanel.setAlignmentX(Component.LEFT_ALIGNMENT);
        JButton btnSign = new JButton("KÝ XÁC NHẬN");
        btnSign.setPreferredSize(new Dimension(200, 45));
        btnSign.setFont(new Font("Arial", Font.BOLD, 14));
        btnSign.setBackground(new Color(220, 53, 69));
        btnSign.setForeground(Color.WHITE);
        btnSign.setFocusPainted(false);
        signPanel.add(btnSign);
        
        // 4. Kết quả chữ ký
        JLabel lblSignature = new JLabel("Bước 3: Kết quả chữ ký (Copy dán vào Web)");
        lblSignature.setFont(new Font("Arial", Font.BOLD, 13));
        lblSignature.setAlignmentX(Component.LEFT_ALIGNMENT);
        txtSignature = new JTextArea(4, 50);
        txtSignature.setLineWrap(true);
        txtSignature.setEditable(false);
        txtSignature.setBackground(new Color(245, 245, 245));
        JScrollPane scrollSign = new JScrollPane(txtSignature);
        scrollSign.setAlignmentX(Component.LEFT_ALIGNMENT);

        // Nút Copy
        JPanel copyPanel = new JPanel();
        copyPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
        copyPanel.setAlignmentX(Component.LEFT_ALIGNMENT);
        JButton btnCopy = new JButton("Copy chữ ký");
        btnCopy.setFont(new Font("Arial", Font.PLAIN, 12));
        copyPanel.add(btnCopy);

        // Thêm vào mainPanel
        mainPanel.add(lblData);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 5)));
        mainPanel.add(dataPanel);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 5)));
        mainPanel.add(lblPreview);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 3)));
        mainPanel.add(scrollPreview);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 15)));
        mainPanel.add(lblKey);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 5)));
        mainPanel.add(keyPanel);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 15)));
        mainPanel.add(signPanel);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 15)));
        mainPanel.add(lblSignature);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 5)));
        mainPanel.add(scrollSign);
        mainPanel.add(Box.createRigidArea(new Dimension(0, 5)));
        mainPanel.add(copyPanel);

        add(new JScrollPane(mainPanel));

        // === SỰ KIỆN ===

        // Chọn file đơn hàng
        btnBrowseData.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                loadOrderData();
            }
        });

        // Chọn file Private Key
        btnBrowseKey.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                loadPrivateKey();
            }
        });

        // Ký
        btnSign.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                signData();
            }
        });

        // Copy
        btnCopy.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String sig = txtSignature.getText().trim();
                if (!sig.isEmpty()) {
                    java.awt.datatransfer.StringSelection sel = new java.awt.datatransfer.StringSelection(sig);
                    java.awt.Toolkit.getDefaultToolkit().getSystemClipboard().setContents(sel, null);
                    JOptionPane.showMessageDialog(OfflineSignTool.this, "Đã copy chữ ký vào clipboard!", "Thành công", JOptionPane.INFORMATION_MESSAGE);
                }
            }
        });
    }

    private void loadOrderData() {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setFileFilter(new javax.swing.filechooser.FileNameExtensionFilter("Text files (*.txt)", "txt"));
        int result = fileChooser.showOpenDialog(this);
        if (result == JFileChooser.APPROVE_OPTION) {
            File file = fileChooser.getSelectedFile();
            try {
                orderData = new String(Files.readAllBytes(file.toPath()), "UTF-8").trim();
                txtDataFilePath.setText(file.getAbsolutePath());
                txtDataPreview.setText(orderData);
                txtSignature.setText("");
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(this, "Lỗi đọc file: " + ex.getMessage(), "Lỗi", JOptionPane.ERROR_MESSAGE);
                orderData = null;
            }
        }
    }

    private void loadPrivateKey() {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setFileFilter(new javax.swing.filechooser.FileNameExtensionFilter("PEM files (*.pem)", "pem"));
        int result = fileChooser.showOpenDialog(this);
        if (result == JFileChooser.APPROVE_OPTION) {
            File file = fileChooser.getSelectedFile();
            try {
                String keyStr = new String(Files.readAllBytes(file.toPath()));
                keyStr = keyStr.replaceAll("-----BEGIN PRIVATE KEY-----", "")
                               .replaceAll("-----END PRIVATE KEY-----", "")
                               .replaceAll("\\s+", "");

                byte[] keyBytes = Base64.getDecoder().decode(keyStr);
                PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
                KeyFactory kf = KeyFactory.getInstance("RSA");
                privateKey = kf.generatePrivate(spec);
                
                txtKeyPath.setText(file.getAbsolutePath());
                txtSignature.setText("");
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(this, "Lỗi đọc file khóa: " + ex.getMessage(), "Lỗi", JOptionPane.ERROR_MESSAGE);
                privateKey = null;
                txtKeyPath.setText("Lỗi khóa!");
            }
        }
    }

    private void signData() {
        if (orderData == null || orderData.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Vui lòng chọn file dữ liệu đơn hàng trước!", "Lỗi", JOptionPane.ERROR_MESSAGE);
            return;
        }
        if (privateKey == null) {
            JOptionPane.showMessageDialog(this, "Vui lòng chọn file Private Key trước!", "Lỗi", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try {
            Signature signature = Signature.getInstance("SHA256withRSA");
            signature.initSign(privateKey);
            signature.update(orderData.getBytes("UTF-8"));
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
