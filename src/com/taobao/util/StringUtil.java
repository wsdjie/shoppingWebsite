package com.taobao.util;

import java.text.DecimalFormat;

public class StringUtil {
	/**
	 * ��֤�ַ����Ƿ�Ϊ�գ�null����ַ�����
	 * @param str Ҫ��֤���ַ���
	 * @return ��֤������ַ���Ϊ�շ���true�����򷵻�false��
	 */
	public static boolean isNullOrEmpty(String str){
		if(str == null || "".equals(str.trim())){
			return true;
		}
		return false;
	}
	
	/*
	 * �����ַ������ֽڳ���(��ĸ���ּ�1�����ּ�����2) ���� ����
	 */
	public static int byteLength(String str) {
		int count = 0;
		for (int i = 0; i < str.length(); i++) {
			if (Integer.toHexString(str.charAt(i)).length() == 4) {
				count += 2;
			} else {
				count++;
			}
		}
		return count;
	}
	/**
	 * ��ָ�����ȣ�ʡ���ַ��������ַ�
	 * @param str �ַ���
	 * @param len �����ַ�������
	 * @return ʡ�Ժ���ַ���
	 */
	public static String omitString(String str, int len) {
		StringBuffer sb = new StringBuffer();
		if (byteLength(str) > len) {
			int count = 0;
			for (int i = 0; i < str.length(); i++) {
				char temp = str.charAt(i);
				if (Integer.toHexString(temp).length() == 4) {
					count += 2;
				} else {
					count++;
				}
				if (count < len - 3) {
					sb.append(temp);
				}
				if (count == len - 3) {
					sb.append(temp);
					break;
				}
				if (count > len - 3) {
					sb.append(" ");
					break;
				}
			}
			sb.append("...");
		} else {
			sb.append(str);
		}
		return sb.toString();
	}
	/**
	 * ��ʽ��������Ϊ��λС��
	 * @param value
	 * @return
	 */
	public static String formatDouble(double value){
		DecimalFormat df = new DecimalFormat("0.00");
		return df.format(value);
	}
}
