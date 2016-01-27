package com.common;

import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;

public class ZipImg {
	public static void main(String[] args) {
		try {
			zipImgSize("F:/tupian/c.jpg", "F:/tupian/ccc.jpg", 1f);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void zipImgSize(String inputfileName, String outputfileName,
			float f) throws IOException {
		BufferedImage bufferedImage = ImageIO.read(new File(inputfileName));
		byte[] b = bufferedImageTobytes(bufferedImage, f);
		OutputStream output = new FileOutputStream(outputfileName);
		for (int i = 0; i < b.length; i++) {
			output.write(b[i]);
		}
		output.flush();
		output.close();
	}

	public static byte[] bufferedImageTobytes(BufferedImage mage, float quality) {

		// 得到指定Format图片的writer
		Iterator<ImageWriter> iter = ImageIO
				.getImageWritersByFormatName("jpeg");// 得到迭代器
		ImageWriter writer = (ImageWriter) iter.next(); // 得到writer

		// 得到指定writer的输出参数设置(ImageWriteParam )
		ImageWriteParam iwp = writer.getDefaultWriteParam();
		iwp.setCompressionMode(ImageWriteParam.MODE_EXPLICIT); // 设置可否压缩
		iwp.setCompressionQuality(quality); // 设置压缩质量参数

		iwp.setProgressiveMode(ImageWriteParam.MODE_DISABLED);
		ColorModel colorModel = ColorModel.getRGBdefault();
		// 指定压缩时使用的色彩模式
		iwp.setDestinationType(new javax.imageio.ImageTypeSpecifier(colorModel,
				colorModel.createCompatibleSampleModel(16, 16)));

		// 开始打包图片，写入byte[]
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream(); // 取得内存输出流
		IIOImage iIamge = new IIOImage(mage, null, null);
		try {
			// 此处因为ImageWriter中用来接收write信息的output要求必须是ImageOutput
			// 通过ImageIo中的静态方法，得到byteArrayOutputStream的ImageOutput
			writer.setOutput(ImageIO
					.createImageOutputStream(byteArrayOutputStream));
			writer.write(null, iIamge, iwp);
		} catch (IOException e) {
			System.out.println("write errro");
			e.printStackTrace();
		}
		return byteArrayOutputStream.toByteArray();
	}

	public static void zipImgQuality(File uploadFile, String absolute,
			String newfilename, float f) {
		try {
			byte[] b;
			BufferedImage bufferedImage = ImageIO.read(uploadFile);
			if (bufferedImage.getWidth(null) == -1) {
				Commonparam.makeFile(uploadFile, absolute, newfilename);
			} else {
				File absoluteFolder = new File(absolute);
				if (!absoluteFolder.exists()) {
					absoluteFolder.mkdirs();
				}
				b = bufferedImageTobytes(bufferedImage, f);
				OutputStream output = new FileOutputStream(absolute
						+ newfilename);
				for (int i = 0; i < b.length; i++) {
					output.write(b[i]);
				}
				output.flush();
				output.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static byte[] bufferedImageTobytes(BufferedImage image) {
		ByteArrayOutputStream bs = new ByteArrayOutputStream();
		InputStream is = null;
		ImageOutputStream imOut;
		try {
			image.getType();
			imOut = ImageIO.createImageOutputStream(bs);
			ImageIO.write(image, "jpg", imOut);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return bs.toByteArray();
	}
	
	 public static String bytesToHexString(byte[] src){      
	        StringBuilder stringBuilder = new StringBuilder();      
	        if (src == null || src.length <= 0) {      
	            return null;      
	        }      
	        for (int i = 0; i < src.length; i++) {      
	            int v = src[i] & 0xFF;      
	            String hv = Integer.toHexString(v);      
	            if (hv.length() < 2) {      
	                stringBuilder.append(0);      
	            }      
	            stringBuilder.append(hv);      
	        }      
	        return stringBuilder.toString().toUpperCase();      
	    } 
}
