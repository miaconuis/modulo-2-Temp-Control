classdef DHT11 < matlab.System ...
        & coder.ExternalDependency ...
        & matlabshared.sensors.simulink.internal.BlockSampleTime

    % temperatura y humedad dht11
    %#codegen
    %#ok<*EMCA>

    properties
        BlockParameter = uint32(0);
    end

    properties(Access = protected)
        Logo = 'IO Device Builder';
    end

    properties (Nontunable)

    end

    properties (Access = private)


    end

    methods
        % Constructor
        function obj = DHT11(varargin)
            setProperties(obj,nargin,varargin{:});
        end
    end

    methods (Access=protected)
        function setupImpl(obj)
            if coder.target('RtwForRapid')
                % Rapid Accelerator. In this mode, coder.target('Rtw')
                % returns true as well, so it is important to check for
                % 'RtwForRapid' before checking for 'Rtw'

                %pass
            elseif ~coder.target('MATLAB')
                coder.cinclude('DHT11.h');
                coder.ceval('setupFunctionDHT11', coder.ref(obj.BlockParameter),1);
            end
        end

        function validateInputsImpl(obj,varargin)
            %  Check the input size
            if nargin ~=0



            end
        end

        function [Tempertatura,Humedad] =  stepImpl(obj)
            Tempertatura = single(zeros(1,1));
            Humedad = single(zeros(1,1));
            if isempty(coder.target)
            elseif coder.target('RtwForRapid')
                % Rapid Accelerator. In this mode, coder.target('Rtw')
                % returns true as well, so it is important to check for
                % 'RtwForRapid' before checking for 'Rtw'

                %pass
            else
                coder.ceval('stepFunctionDHT11',coder.ref(Tempertatura),1,coder.ref(Humedad),1, coder.ref(obj.BlockParameter),1);
            end
        end

        function releaseImpl(obj)
            if isempty(coder.target)
            elseif coder.target('RtwForRapid')
                % Rapid Accelerator. In this mode, coder.target('Rtw')
                % returns true as well, so it is important to check for
                % 'RtwForRapid' before checking for 'Rtw'

                %pass
            else

            end
        end
    end

    methods (Access=protected)
        %% Define output properties
        function num = getNumInputsImpl(~)
            num = 0;
        end

        function num = getNumOutputsImpl(~)
            num = 2;
        end

        function varargout = getInputNamesImpl(obj)

        end

        function varargout = getOutputNamesImpl(obj)
            varargout{1} = 'Tempertatura';
            varargout{2} = 'Humedad';
        end

        function flag = isOutputSizeLockedImpl(~,~)
            flag = true;
        end

        function varargout = isOutputFixedSizeImpl(~,~)
            varargout{1} = true;
            varargout{2} = true;
        end

        function varargout = isOutputComplexImpl(~)
            varargout{1} = false;
            varargout{2} = false;
        end

        function varargout = getOutputSizeImpl(~)
            varargout{1} = [1,1];
            varargout{2} = [1,1];
        end

        function varargout = getOutputDataTypeImpl(~)
            varargout{1} = 'single';
            varargout{2} = 'single';
        end

        function maskDisplayCmds = getMaskDisplayImpl(obj)
            outport_label = [];
            num = getNumOutputsImpl(obj);
            if num > 0
                outputs = cell(1,num);
                [outputs{1:num}] = getOutputNamesImpl(obj);
                for i = 1:num
                    outport_label = [outport_label 'port_label(''output'',' num2str(i) ',''' outputs{i} ''');' ]; %#ok<AGROW>
                end
            end
            inport_label = [];
            num = getNumInputsImpl(obj);
            if num > 0
                inputs = cell(1,num);
                [inputs{1:num}] = getInputNamesImpl(obj);
                for i = 1:num
                    inport_label = [inport_label 'port_label(''input'',' num2str(i) ',''' inputs{i} ''');' ]; %#ok<AGROW>
                end
            end
            icon = 'DHT11';
            maskDisplayCmds = [ ...
                ['color(''white'');',...
                'plot([100,100,100,100]*1,[100,100,100,100]*1);',...
                'plot([100,100,100,100]*0,[100,100,100,100]*0);',...
                'color(''blue'');', ...
                ['text(38, 92, ','''',obj.Logo,'''',',''horizontalAlignment'', ''right'');',newline],...
                'color(''black'');'], ...
                ['text(52,50,' [''' ' icon ''',''horizontalAlignment'',''center'');' newline]]   ...
                inport_label ...
                outport_label
                ];
        end

        function sts = getSampleTimeImpl(obj)
            sts = getSampleTimeImpl@matlabshared.sensors.simulink.internal.BlockSampleTime(obj);
        end
    end

    methods (Static, Access=protected)
        function simMode = getSimulateUsingImpl(~)
            simMode = 'Interpreted execution';
        end

        function isVisible = showSimulateUsingImpl
            isVisible = false;
        end
    end

    methods (Static)
        function name = getDescriptiveName(~)
            name = 'DHT11';
        end

        function tf = isSupportedContext(~)
            tf = true;
        end

        function updateBuildInfo(buildInfo, context)
            coder.extrinsic('codertarget.targethardware.getTargetHardware');
            isRaccelBuild = strcmp(context.getConfigProp('SystemTargetFile'), 'raccel.tlc');
            if ~isRaccelBuild
                hCS = coder.const(getActiveConfigSet(bdroot));
                targetInfo = coder.const(codertarget.targethardware.getTargetHardware(hCS));

                % Added this env variable to fetch the comm libraries required only for Arduino target.
                % The env variable is cleared at the end of
                % "GenerateWrapperMakefile.m" file.
                if contains(targetInfo.TargetName,'arduinotarget')
                    setenv('Arduino_ML_Codegen_I2C', 'Y');
                end

                filename = mfilename('fullpath');
                [filepath,~,~] = fileparts(filename);

                DriverFiles = {'Adafruit_Sensor.cpp','DHT.cpp','DHT_U.cpp',};
                DriverFilesFolder = 'Dependencies';
                SystemObjFiles = {'DHT11.cpp'};




                buildInfo.addSourceFiles(SystemObjFiles,filepath);
                buildInfo.addSourceFiles(DriverFiles,fullfile(filepath,DriverFilesFolder));
                buildInfo.addIncludePaths(filepath);
                buildInfo.addIncludePaths(fullfile(filepath,DriverFilesFolder));
            end
        end
    end
end

function mustBeData(a,dataType)
% As the 'isa' function doesnot support boolean datatype, change to 'logical' %
if isequal(dataType,'boolean')
    dataType = 'logical';
end

if ~(isa(a,dataType))
    error("Value must of type %s.",dataType);
end
end

function mustBeSize(value, expectedSize)
% Get the actual size of the input
actualSize = size(value);

% Check if the actual size matches the expected size
if ~isequal(actualSize, expectedSize)
    error(message('devicedriverapp_resources:messages:ParameterSizeValidation',num2str(expectedSize), num2str(actualSize)).getString);
end
end

function value = getValueFromTypeName(typeName)
keys = {'double', 'single','uint8', 'uint16', 'uint32', 'uint64', ...
    'int8', 'int16', 'int32', 'int64'};
values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

% Find the index of the type name
index = find(strcmp(keys, typeName));

if isempty(index)
    value = -1;
else
    value = values(index);
end
end

