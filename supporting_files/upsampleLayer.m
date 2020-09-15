classdef upsampleLayer < nnet.layer.Layer

%  Copyright 2020 The MathWorks, Inc.    
    methods
        function layer = upsampleLayer(name)
            
             % Set layer name.
            layer.Name = name;

            % Set layer description.
            layer.Description = "Upsample Conv";
            
        end
        
        function dlZ = predict(~, dlX)
            
            [h, w, c, n] = size(dlX,1:4);
            
            dlZ = zeros([2*h 2*w c n],'like',dlX);
            
            dlZ(1:2:end,1:2:end,:,:) = dlX;
            dlZ(1:2:end,2:2:end,:,:) = dlX;
            dlZ(2:2:end,1:2:end,:,:) = dlX;
            dlZ(2:2:end,2:2:end,:,:) = dlX;
        end
    end   
end