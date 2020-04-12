function map = pos_attention(R, win, frame, target_sz, trans_vec)
pre_output = pos_pre(R, win);
size_R = size(R);
if frame < 3
    map = pre_output;
else
    if norm(trans_vec) == 0
        map = pre_output;
    else
        % ���ֵ��λ0.5
        % 4̫���ˣ�3��΢��ȥ�˵���û��
        motion_level = norm(trans_vec) / norm(target_sz)* 2; 
%         motion_level = norm(trans_vec) / norm(target_sz) * 2;
        % ��ȡ��λ������the motion_direct should resize accorinding to the traget_sz
        resize_vec = trans_vec ./ target_sz;
        motion_direct = resize_vec/norm(resize_vec);
        % �ƶ�����ȡ��
        motion_vec = round(motion_level * size_R(1:2) .* motion_direct);
        motion_map = circshift(pre_output, motion_vec);
        map = pre_output + motion_level * motion_map;
    end
end
end